-- PUBLIC_INTERFACE
-- Migration 001: Initial schema for students, attendance_records, sessions.
-- Apply order: 001_init.sql

-- Ensure uuid extension for UUID generation helpers if needed later
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Students table
CREATE TABLE IF NOT EXISTS students (
  id UUID PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Attendance records table
CREATE TABLE IF NOT EXISTS attendance_records (
  id UUID PRIMARY KEY,
  student_id UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  period TEXT NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('present','absent')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Sessions table (for simple token-based auth if needed)
CREATE TABLE IF NOT EXISTS sessions (
  id UUID PRIMARY KEY,
  student_id UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
  token TEXT NOT NULL UNIQUE,
  expires_at TIMESTAMPTZ NOT NULL
);

-- Helpful index to speed up daily lookups and reporting
CREATE INDEX IF NOT EXISTS idx_attendance_records_student_date
  ON attendance_records (student_id, date);

-- Also index date alone for daily aggregates
CREATE INDEX IF NOT EXISTS idx_attendance_records_date
  ON attendance_records (date);
