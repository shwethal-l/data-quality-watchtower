# Data Quality Watchtower (AI-first Prototype)

## Overview
Data Quality Watchtower is a lightweight AI-driven prototype that monitors structured data outputs
(such as transcripts and extraction results) and automatically flags quality issues like missing fields
and low confidence scores.

This project demonstrates how AI workflows can be used to proactively detect data quality risks
before they impact downstream systems.

---

## Problem Statement
Modern AI pipelines (OCR, transcription, extraction) often fail silently:
Missing speakers
Low confidence scores
Vendor inconsistencies

These issues usually go unnoticed until they affect analytics or customers.

---

## Solution
This prototype uses:
**Supabase** as the data source
**n8n** for workflow automation
**JavaScript logic** to detect anomalies

The system scans incoming records and flags:
Missing speaker information
Confidence scores below a defined threshold

---

## Architecture
1. Data stored in Supabase (transcript_runs table)
2. n8n workflow fetches records
3. JavaScript logic evaluates quality rules
4. Detected issues are returned as structured anomaly records

---

## Example Anomaly Output
{
  "anomaly_type": "data_quality_issue",
  "severity": "medium",
  "summary": "Missing speaker or low confidence detected",
  "recommended_action": "Review vendor output and OCR/extraction settings"
}
