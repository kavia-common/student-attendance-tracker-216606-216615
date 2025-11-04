import express, { Request, Response, NextFunction } from "express";
import helmet from "helmet";
import cors from "cors";
import rateLimit from "express-rate-limit";
import { loadEnv } from "./utils/env";
import authRoutes from "./routes/auth";
import attendanceRoutes from "./routes/attendance";
import sseRoutes from "./routes/sse";

loadEnv();

const app = express();

// Security, CORS, JSON parsing
app.use(helmet());
app.use(
  cors({
    origin: (origin, callback) => {
      const raw = process.env.CORS_ORIGIN || "*";
      if (raw === "*" || !origin) return callback(null, true);
      const allowed = raw.split(",").map(s => s.trim());
      return callback(null, allowed.includes(origin));
    },
    credentials: false
  })
);
app.use(express.json({ limit: "1mb" }));

// Rate limiting for basic abuse protection
app.use(
  rateLimit({
    windowMs: 15 * 60 * 1000,
    limit: 500,
    standardHeaders: true,
    legacyHeaders: false
  })
);

// PUBLIC_INTERFACE
// Root: health info and basic metadata
app.get("/", (_req: Request, res: Response) => {
  /**
   * This endpoint returns basic API health/metadata.
   * Returns:
   * 200: { name, version, description, uptime }
   */
  res.json({
    name: "Attendance API",
    version: "1.0.0",
    description: "Express + TypeScript API for attendance tracking",
    uptime: process.uptime()
  });
});

/**
 * PUBLIC_INTERFACE
 * OpenAPI YAML helper route: returns the static openapi.yaml and SSE usage tips.
 */
app.get("/api/docs", (_req: Request, res: Response) => {
  res.json({
    message: "OpenAPI spec available at project file openapi.yaml",
    sse: {
      endpoint: "/api/sse/attendance",
      note: "Use EventSource or curl -N with Authorization: Bearer <token>"
    }
  });
});

// Grouped routes
app.use("/api/auth", authRoutes);
app.use("/api/attendance", attendanceRoutes);
app.use("/api/sse", sseRoutes);

// 404 handler
app.use((_req: Request, res: Response) => {
  res.status(404).json({ error: "Not Found" });
});

// Error handler
// eslint-disable-next-line @typescript-eslint/no-unused-vars
app.use((err: any, _req: Request, res: Response, _next: NextFunction) => {
  // Standard error surface with minimal leakage
  console.error("Unhandled error:", err);
  const status = typeof err.status === "number" ? err.status : 500;
  res.status(status).json({
    error: err.message || "Internal Server Error"
  });
});

export default app;
