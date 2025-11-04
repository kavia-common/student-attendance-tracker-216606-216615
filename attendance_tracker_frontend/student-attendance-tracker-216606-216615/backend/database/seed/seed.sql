-- PUBLIC_INTERFACE
-- Seed data for demo usage. Safe to run multiple times via ON CONFLICT clauses.

-- Upsert demo students
INSERT INTO students (id, name, email)
VALUES
  ('00000000-0000-0000-0000-000000000001', 'Alice Johnson', 'alice@example.com'),
  ('00000000-0000-0000-0000-000000000002', 'Bob Smith', 'bob@example.com'),
  ('00000000-0000-0000-0000-000000000003', 'Charlie Kim', 'charlie@example.com')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  email = EXCLUDED.email;

-- Seed attendance for today for demo users
-- Uses current_date so it remains relevant
INSERT INTO attendance_records (id, student_id, date, period, status)
VALUES
  ('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', CURRENT_DATE, 'Period 1', 'present'),
  ('10000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000002', CURRENT_DATE, 'Period 1', 'absent'),
  ('10000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000003', CURRENT_DATE, 'Period 1', 'present'),
  ('10000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000001', CURRENT_DATE, 'Period 2', 'present'),
  ('10000000-0000-0000-0000-000000000005', '00000000-0000-0000-0000-000000000002', CURRENT_DATE, 'Period 2', 'present'),
  ('10000000-0000-0000-0000-000000000006', '00000000-0000-0000-0000-000000000003', CURRENT_DATE, 'Period 2', 'absent')
ON CONFLICT (id) DO NOTHING;
