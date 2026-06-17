#!/usr/bin/env node
// KISS — SessionStart hook. Unless turned off, writes the "on" flag (so the
// statusline badge has something to read) and injects the ruleset as context.

const fs = require("fs");
const path = require("path");
const os = require("os");

const claudeDir = process.env.CLAUDE_CONFIG_DIR || path.join(os.homedir(), ".claude");
const flag = path.join(claudeDir, ".kiss-active");
const skill = path.join(__dirname, "..", "skills", "kiss", "SKILL.md");

const state = fs.existsSync(flag) ? fs.readFileSync(flag, "utf8").trim() : "on";
if (state === "off") process.exit(0);

try {
	fs.mkdirSync(claudeDir, { recursive: true });
	fs.writeFileSync(flag, "on");
} catch (e) {
	// Best-effort — never block session start.
}

const body = fs.readFileSync(skill, "utf8").replace(/^---[\s\S]*?---\s*/, "");
process.stdout.write(`KISS MODE ACTIVE — Keep It Simple, Stupid\n\n${body}`);
