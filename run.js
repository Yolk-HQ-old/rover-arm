#!/usr/bin/env node
const { spawnSync } = require("child_process");
const { join } = require("path");

const [, , ...args] = process.argv;
const options = { pwd: process.cwd(), stdio: "inherit" };
const rover = join(__dirname, "rover");
const result = spawnSync(rover, args, options);
if (result.error) {
  console.error(result.error);
  process.exit(1);
}
process.exit(result.status);
