import { Router, Response } from "express";
import Joi from "joi";
import { validateBody } from "../middleware/validation";
import { requireAuth, AuthedRequest } from "../middleware/auth";
import { getDaily, getWeekly, markAttendance } from "../services/attendanceService";
import { publish } from "../services/realtimeService";

const router = Router();

const markSchema = Joi.object({
  studentId: Joi.string().uuid().required(),
  date: Joi.string().pattern(/^\d{4}-\d{2}-\d{2}$/).required(),
  period: Joi.string().min(1).required(),
  status: Joi.string().valid("present", "absent").required()
});

// PUBLIC_INTERFACE
// POST /api/attendance/mark - create attendance record
router.post(
  "/mark",
  requireAuth,
  validateBody(markSchema),
  async (req: AuthedRequest, res: Response) => {
    /**
     * summary: Mark attendance
     * description: Creates an attendance record for a student on a given date/period with present/absent status.
     * security: Bearer token required
     * returns: 201 AttendanceRecord
     */
    const { studentId, date, period, status } = req.body as {
      studentId: string; date: string; period: string; status: "present" | "absent";
    };
    try {
      const record = await markAttendance({ studentId, date, period, status });
      // Publish realtime event
      publish("attendance.marked", record);
      res.status(201).json(record);
    } catch (e: any) {
      res.status(500).json({ error: e.message || "Failed to mark attendance" });
    }
  }
);

// PUBLIC_INTERFACE
// GET /api/attendance/daily?date=YYYY-MM-DD
router.get(
  "/daily",
  requireAuth,
  async (req: AuthedRequest, res: Response) => {
    /**
     * summary: Daily attendance
     * description: Fetch all attendance records for the provided date.
     * query: date=YYYY-MM-DD
     * returns: 200 AttendanceRecord[]
     */
    const dateRaw = req.query.date;
    if (!dateRaw || typeof dateRaw !== "string") {
      return res.status(400).json({ error: "date query param is required (YYYY-MM-DD)" });
    }
    const date = String(dateRaw);
    if (!/^\d{4}-\d{2}-\d{2}$/.test(date)) {
      return res.status(400).json({ error: "date must be YYYY-MM-DD" });
    }
    try {
      const rows = await getDaily(date);
      res.json(rows);
    } catch (e: any) {
      res.status(500).json({ error: e.message || "Failed to fetch daily" });
    }
  }
);

// PUBLIC_INTERFACE
// GET /api/attendance/weekly?weekStart=YYYY-MM-DD
router.get(
  "/weekly",
  requireAuth,
  async (req: AuthedRequest, res: Response) => {
    /**
     * summary: Weekly attendance
     * description: Fetch attendance for week range [weekStart, weekStart+6].
     * query: weekStart=YYYY-MM-DD
     * returns: 200 AttendanceRecord[]
     */
    const weekStartRaw = req.query.weekStart;
    if (!weekStartRaw || typeof weekStartRaw !== "string") {
      return res.status(400).json({ error: "weekStart query param is required (YYYY-MM-DD)" });
    }
    const weekStart = String(weekStartRaw);
    if (!/^\d{4}-\d{2}-\d{2}$/.test(weekStart)) {
      return res.status(400).json({ error: "weekStart must be YYYY-MM-DD" });
    }
    try {
      const rows = await getWeekly(weekStart);
      res.json(rows);
    } catch (e: any) {
      res.status(500).json({ error: e.message || "Failed to fetch weekly" });
    }
  }
);

export default router;
