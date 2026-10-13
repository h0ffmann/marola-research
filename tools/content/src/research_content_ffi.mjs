// The few things the content generator needs from Node: files, its arguments and one git command.
import { readFileSync, writeFileSync, readdirSync, existsSync } from "node:fs";
import { execSync } from "node:child_process";

// The file's text, or "" when it does not exist.
export function read(path) {
  return existsSync(path) ? readFileSync(path, "utf8") : "";
}

export function write(path, text) {
  writeFileSync(path, text);
}

// The names of the .md files of a directory, sorted, one on each line.
export function markdown_files(dir) {
  if (!existsSync(dir)) return "";
  return readdirSync(dir)
    .filter((f) => f.endsWith(".md"))
    .sort()
    .join("\n");
}

// The short hash of the commit that is built, or "unversioned" outside a Git checkout.
export function revision() {
  try {
    return execSync("git rev-parse --short HEAD", { stdio: ["ignore", "pipe", "ignore"] })
      .toString()
      .trim();
  } catch (_) {
    return "unversioned";
  }
}

// The arguments after `gleam run --`, one on each line.
export function arguments_() {
  return process.argv.slice(2).join("\n");
}
