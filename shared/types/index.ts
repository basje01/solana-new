export type Surface = "web" | "telegram" | "mobile" | "agent" | "payments";
export type Framework = "anchor" | "native" | "none";
export type HarnessId =
  | "next-anchor"
  | "payments"
  | "agent-wallet"
  | "tg-bot"
  | "mobile";

export interface HarnessDefinition {
  id: HarnessId;
  surface: Surface[];
  needs_program: boolean;
  frameworks: Framework[];
  description: string;
}
