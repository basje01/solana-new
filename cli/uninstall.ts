import { existsSync, rmSync, readdirSync } from "node:fs";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";
import { homedir } from "node:os";
import { RESET, DIM, BOLD, GREEN, YELLOW, RED } from "./colors.js";

const __dirname = dirname(fileURLToPath(import.meta.url));

function getSkillsRoot(): string {
  const devPath = join(__dirname, "..", "skills");
  if (existsSync(devPath)) return devPath;
  const distPath = join(__dirname, "..", "..", "skills");
  if (existsSync(distPath)) return distPath;
  return "";
}

function discoverExpectedSkills(): string[] {
  const root = getSkillsRoot();
  if (!root) return [];
  const phases = ["idea", "build", "launch"];
  const skills: string[] = [];
  for (const phase of phases) {
    const phaseDir = join(root, phase);
    if (!existsSync(phaseDir)) continue;
    for (const entry of readdirSync(phaseDir, { withFileTypes: true })) {
      if (entry.isDirectory() && existsSync(join(phaseDir, entry.name, "SKILL.md"))) {
        skills.push(entry.name);
      }
    }
  }
  return skills;
}

export function cmdUninstall(agent: boolean): void {
  const expected = discoverExpectedSkills();
  const claudeSkillsDir = join(homedir(), ".claude", "skills");
  const codexSkillsDir = join(homedir(), ".codex", "skills");
  const removed: string[] = [];

  for (const skill of expected) {
    const claudePath = join(claudeSkillsDir, skill);
    if (existsSync(claudePath)) {
      rmSync(claudePath, { recursive: true, force: true });
      removed.push(skill);
    }
    const codexPath = join(codexSkillsDir, skill);
    if (existsSync(codexPath)) {
      rmSync(codexPath, { recursive: true, force: true });
    }
  }

  if (agent) {
    if (removed.length === 0) {
      console.log("No skills to remove.");
    } else {
      console.log(`Removed ${removed.length} skills from ~/.claude/skills/:`);
      for (const s of removed) console.log(`  - ${s}`);
      console.log("\nRun solana-new init to reinstall.");
    }
    return;
  }

  console.log("");
  if (removed.length === 0) {
    console.log(`  ${DIM}No skills installed to remove.${RESET}`);
  } else {
    console.log(`  ${BOLD}Removed ${removed.length} skills:${RESET}`);
    console.log("");
    for (const s of removed) console.log(`    ${RED}-${RESET} ${s}`);
    console.log("");
    console.log(`  ${DIM}Run ${BOLD}solana-new init${RESET}${DIM} to reinstall.${RESET}`);
  }
  console.log("");
}
