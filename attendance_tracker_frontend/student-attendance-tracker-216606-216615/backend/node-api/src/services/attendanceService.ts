import { withClient } from "../db/connection";
import { AttendanceRecord, AttendanceStatus } from "../models/types";
import { v4 as uuidv4 } from "uuid";

/**
 * PUBLIC_INTERFACE
 * Create a new attendance record for a given student and date.
 */
export async function markAttendance(opts: {
  studentId: string;
  date: string; // YYYY-MM-DD
  period: string;
  status: AttendanceStatus;
}): Promise<AttendanceRecord> {
  const id = uuidv4();
  return withClient(async (c) => {
    const insert = await c.query<AttendanceRecord>(
      `INSERT INTO attendance_records (id, student_id, date, period, status)
       VALUES ($1, $2, $3, $4, $5)
       RETURNING id, student_id, date, period, status, created_at`,
      [id, opts.studentId, opts.date, opts.period, opts.status]
    );
    return insert.rows[0];
  });
}

/**
 * PUBLIC_INTERFACE
 * Get attendance by date.
 */
export async function getDaily(date: string): Promise<AttendanceRecord[]> {
  return withClient(async (c) => {
    const { rows } = await c.query<AttendanceRecord>(
      `SELECT id, student_id, date, period, status, created_at
         FROM attendance_records
        WHERE date = $1
        ORDER BY period ASC, created_at DESC`,
      [date]
    );
    return rows;
  });
}

/**
 * PUBLIC_INTERFACE
 * Get attendance for [weekStart, weekStart+6].
 */
export async function getWeekly(weekStart: string): Promise<AttendanceRecord[]> {
  return withClient(async (c) => {
    const { rows } = await c.query<AttendanceRecord>(
      `SELECT id, student_id, date, period, status, created_at
         FROM attendance_records
        WHERE date >= $1 AND date <= (to_date($1,'YYYY-MM-DD') + interval '6 days')::date
        ORDER BY date ASC, period ASC, created_at DESC`,
      [weekStart]
    );
    return rows;
  });
}
