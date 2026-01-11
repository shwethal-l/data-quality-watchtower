create table transcript_runs (
  id uuid primary key default gen_random_uuid(),
  created_at timestamp with time zone default now(),
  vendor text,
  source text,
  confidence_score float,
  speaker_present boolean
);

create table quality_anomalies (
  id uuid primary key default gen_random_uuid(),
  anomaly_type text,
  severity text,
  summary text,
  recommended_action text,
  detected_at timestamp with time zone default now()
);
-- Seed data
insert into transcript_runs (vendor, source, confidence_score, speaker_present)
values
('VendorA', 'student_transcript', 0.42, false),
('VendorB', 'student_transcript', 0.91, true);
