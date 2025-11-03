import { writeFile } from "node:fs";
import { SemVer } from "semver";

const p = new SemVer(process.argv[2]);

writeFile(
  "tag.txt",
  [p.major, p.minor, p.patch].join("."),
  { encoding: "utf-8" },
);
