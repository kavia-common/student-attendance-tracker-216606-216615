import { Router, Response } from "express";
import { AuthedRequest, requireAuth } from "../middleware/auth";
import { onEvent } from "../services/realtimeService";

const router = Router();

// PUBLIC_INTERFACE
// GET /api/sse/attendance - Server-Sent Events stream for realtime attendance
router.get("/attendance", requireAuth, (req: AuthedRequest, res: Response) => {
  /**
   * summary: SSE attendance stream
   * description: Opens a text/event-stream connection that emits events when attendance is marked.
   * security: Bearer token required
   * returns: text/event-stream
   */
  res.setHeader("Content-Type", "text/event-stream");
  res.setHeader("Cache-Control", "no-cache");
  res.setHeader("Connection", "keep-alive");

  const send = (event: string, data: any) => {
    res.write(`event: ${event}\n`);
    res.write(`data: ${JSON.stringify(data)}\n\n`);
  };

  // Initial heartbeat
  const heartbeat = setInterval(() => res.write(":keepalive\n\n"), 25000);

  const unsubscribe = onEvent((event, data) => {
    if (event.startsWith("attendance.")) {
      send(event, data);
    }
  });

  req.on("close", () => {
    clearInterval(heartbeat);
    unsubscribe();
  });
});

export default router;
