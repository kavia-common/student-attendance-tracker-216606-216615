import { createServer } from "http";
import app from "./app";
import { loadEnv } from "./utils/env";

// Load env early
loadEnv();

const PORT = Number(process.env.PORT || 8080);
const server = createServer(app);

server.listen(PORT, () => {
  // PUBLIC_INTERFACE
  // Server start log for operational readiness.
  console.log(`Attendance API listening on http://localhost:${PORT}`);
});
