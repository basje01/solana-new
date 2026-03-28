import { existsSync, mkdirSync, cpSync, writeFileSync, readdirSync } from "node:fs";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";
import { homedir } from "node:os";
import { spawn } from "node:child_process";
import { RESET, DIM, BOLD, CYAN, GREEN, YELLOW, MAGENTA } from "./colors.js";

const __dirname = dirname(fileURLToPath(import.meta.url));

// Resolve the skills directory relative to the package root
// In dev: cli/ → ../skills/
// In dist: dist/cli/ → ../skills/
function getSkillsRoot(): string {
  // Try relative to source (dev mode via tsx)
  const devPath = join(__dirname, "..", "skills");
  if (existsSync(devPath)) return devPath;
  // Try relative to dist (built mode)
  const distPath = join(__dirname, "..", "..", "skills");
  if (existsSync(distPath)) return distPath;
  throw new Error("Could not find skills directory");
}

interface SkillEntry {
  phase: string;
  name: string;
  srcDir: string;
}

function discoverSkills(): SkillEntry[] {
  const root = getSkillsRoot();
  const phases = ["idea", "build", "launch"];
  const skills: SkillEntry[] = [];

  for (const phase of phases) {
    const phaseDir = join(root, phase);
    if (!existsSync(phaseDir)) continue;
    for (const entry of readdirSync(phaseDir, { withFileTypes: true })) {
      if (entry.isDirectory() && existsSync(join(phaseDir, entry.name, "SKILL.md"))) {
        skills.push({ phase, name: entry.name, srcDir: join(phaseDir, entry.name) });
      }
    }
  }
  return skills;
}

function installSkillsGlobal(agent: boolean): { installed: string[]; skipped: string[] } {
  const claudeSkillsDir = join(homedir(), ".claude", "skills");
  const codexSkillsDir = join(homedir(), ".codex", "skills");
  const skills = discoverSkills();
  const installed: string[] = [];
  const skipped: string[] = [];

  for (const skill of skills) {
    // Install to Claude Code
    const claudeDest = join(claudeSkillsDir, skill.name);
    if (existsSync(claudeDest)) {
      skipped.push(skill.name);
    } else {
      mkdirSync(claudeDest, { recursive: true });
      cpSync(skill.srcDir, claudeDest, {
        recursive: true,
        filter: (src) => {
          // Skip generated artifacts (HTML reports, JSON packs, etc.)
          const base = src.split("/").pop() ?? "";
          if (base.match(/^(idea-shortlist|idea-deep-dive|research-pack|research-worksheet)-\d/)) return false;
          return true;
        },
      });
      installed.push(skill.name);
    }

    // Also install to Codex if .codex directory exists
    if (existsSync(join(homedir(), ".codex"))) {
      const codexDest = join(codexSkillsDir, skill.name);
      if (!existsSync(codexDest)) {
        mkdirSync(codexDest, { recursive: true });
        cpSync(skill.srcDir, codexDest, {
          recursive: true,
          filter: (src) => {
            const base = src.split("/").pop() ?? "";
            if (base.match(/^(idea-shortlist|idea-deep-dive|research-pack|research-worksheet)-\d/)) return false;
            return true;
          },
        });
      }
    }
  }

  return { installed, skipped };
}

function generateProjectClaudeMd(): string {
  let md = `# Solana Project\n\n`;
  md += `## Your Journey: Idea → Build → Launch\n\n`;
  md += `9 skills are pre-loaded. Just ask naturally.\n\n`;

  md += `### Phase 1: Idea\n`;
  md += `- "What should I build in crypto?" — discover and rank ideas\n`;
  md += `- "Validate this idea" — stress-test with demand signals\n`;
  md += `- "Who are my competitors?" — map the landscape\n`;
  md += `- "Show me DeFi opportunities on Solana" — TVL research via DefiLlama\n\n`;

  md += `### Phase 2: Build\n`;
  md += `- "Scaffold my project" — set up workspace with right stack\n`;
  md += `- "Help me build the MVP" — guided implementation\n`;
  md += `- "Review my code" — security audit + quality review\n\n`;

  md += `### Phase 3: Launch\n`;
  md += `- "Deploy to mainnet" — production checklist\n`;
  md += `- "Create a pitch deck" — tailored to your audience\n`;
  md += `- "Prepare my hackathon submission" — optimized for judges\n\n`;

  md += `> Each phase writes context to \`.solana-new/\` so the next phase picks up automatically.\n\n`;

  md += `## Ecosystem\n`;
  md += `- \`solana-new search <query>\` — find repos, skills, MCPs\n`;
  md += `- \`solana-new repos\` — 59 cloneable Solana repos\n`;
  md += `- \`solana-new skills\` — 66 ecosystem skills\n`;
  md += `- \`solana-new mcps\` — 49 MCP servers\n`;

  return md;
}

export async function cmdInit(args: string[], flags: Record<string, string | boolean>): Promise<void> {
  const agent = flags.agent === true;
  const skipClaudeMd = flags["no-claude-md"] === true;

  // Step 1: Install skills globally
  const { installed, skipped } = installSkillsGlobal(agent);
  const total = installed.length + skipped.length;

  if (agent) {
    // Machine-readable output for Claude Code / Codex
    console.log(`solana-new init — ${total} journey skills`);
    console.log(``);
    if (installed.length > 0) {
      console.log(`Installed ${installed.length} skills to ~/.claude/skills/:`);
      for (const s of installed) console.log(`  + ${s}`);
    }
    if (skipped.length > 0) {
      console.log(`Already installed (${skipped.length}):`);
      for (const s of skipped) console.log(`  = ${s}`);
    }
    console.log(``);
    console.log(`Ready. Ask Claude Code:`);
    console.log(`  "What should I build in crypto?"     → Idea phase`);
    console.log(`  "Help me build the MVP"              → Build phase`);
    console.log(`  "Deploy to mainnet"                  → Launch phase`);
  } else {
    // Human-friendly output
    console.log(``);
    console.log(`  ${BOLD}solana-new init${RESET}`);
    console.log(``);

    if (installed.length > 0) {
      console.log(`  ${GREEN}${BOLD}Installed ${installed.length} skills:${RESET}`);
      for (const s of installed) console.log(`    ${GREEN}+${RESET} ${s}`);
      console.log(``);
    }
    if (skipped.length > 0) {
      console.log(`  ${DIM}Already installed (${skipped.length}):${RESET}`);
      for (const s of skipped) console.log(`    ${DIM}= ${s}${RESET}`);
      console.log(``);
    }

    console.log(`  ${BOLD}Skills installed to:${RESET}`);
    console.log(`    ${CYAN}~/.claude/skills/${RESET}  ${DIM}(Claude Code)${RESET}`);
    if (existsSync(join(homedir(), ".codex"))) {
      console.log(`    ${CYAN}~/.codex/skills/${RESET}  ${DIM}(Codex)${RESET}`);
    }
    console.log(``);
  }

  // Step 2: Generate CLAUDE.md if in a project directory and not skipped
  if (!skipClaudeMd && !existsSync("CLAUDE.md")) {
    writeFileSync("CLAUDE.md", generateProjectClaudeMd());
    if (agent) {
      console.log(`Generated: CLAUDE.md (journey guide for this project)`);
    } else {
      console.log(`  ${GREEN}+${RESET} Generated ${BOLD}CLAUDE.md${RESET} with journey guide`);
      console.log(``);
    }
  }

  if (!agent) {
    console.log(`  ${YELLOW}${BOLD}Launch Claude Code:${RESET}`);
    console.log(`  ${MAGENTA}$ solana-new journey${RESET}  ${DIM}pick a skill → opens Claude Code with prompt${RESET}`);
    console.log(`  ${MAGENTA}$ claude "What should I build in crypto?"${RESET}`);
    console.log(``);
  }
}
