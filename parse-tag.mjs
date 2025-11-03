import { writeFileSync } from "node:fs";
import { SemVer } from "semver";

const p = new SemVer(process.argv[2]);

writeFileSync(
  "tag.txt",
  [p.major, p.minor, p.patch].join("."),
  { encoding: "utf-8" },
);
