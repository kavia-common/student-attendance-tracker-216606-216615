import path from "path";
import dotenv from "dotenv";

let loaded = false;

export function loadEnv() {
  if (loaded) return;
  dotenv.config({ path: path.resolve(process.cwd(), ".env") });
  loaded = true;
}
