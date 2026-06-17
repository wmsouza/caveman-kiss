#!/usr/bin/env node
// KISS: UserPromptSubmit hook. Watches the prompt for "/caveman-kiss" (on),
// "/caveman-kiss off", "stop kiss", or "normal mode" and rewrites the on/off flag.

const fs = require("fs");
const path = require("path");
const os = require("os");

const claudeDir = process.env.CLAUDE_CONFIG_DIR || path.join(os.homedir(), ".claude");
const flag = path.join(claudeDir, ".kiss-active");

let input = "";
process.stdin.on("data", (c) => (input += c));
process.stdin.on("end", () => {
	try {
		const prompt = (JSON.parse(input.replace(/^﻿/, "")).prompt || "")
			.trim()
			.toLowerCase();

		const write = (state) => {
			fs.mkdirSync(path.dirname(flag), { recursive: true });
			fs.writeFileSync(flag, state);
		};

		const cmd = prompt.match(/^[/@$]caveman-kiss(?:\s+(off|on))?\b/);
		if (cmd) write(cmd[1] === "off" ? "off" : "on");

		if (/\b(stop kiss|normal mode)\b/.test(prompt)) write("off");
	} catch (e) {
		// Silent fail; flag is best-effort, never block the prompt.
	}
});
