export type AttendanceStatus = "present" | "absent";

export interface Student {
  id: string;
  name: string;
  email: string;
  created_at: string;
}

export interface AttendanceRecord {
  id: string;
  student_id: string;
  date: string; // YYYY-MM-DD
  period: string;
  status: AttendanceStatus;
  created_at: string;
}
