# Beyond Destiny - Database & Workflow Management

This repository contains the PostgreSQL database schema, seed data, connection modules, and query definitions for the **Beyond Destiny Wedding Studio Workflow Management System**.

## Schema Hierarchy
- **Users & Roles:** Unified authentication table supporting Owner, Manager, Administrator, and Staff.
- **Staff:** Specialized job roles (`Filter`, `Selector`, `Editor`, `Retoucher`, `Album Designer`, `Full Video Editor`, `Trailer Editor`).
- **Clients & Projects:** Supports bride and groom contact details and project identifiers (e.g., `PROJECT #18`).
- **Tasks & Assignments:** Role-targeted task assignments, priorities, deadlines, and status histories.

## Setup Instructions
1. Run `npm install`
2. Configure your Neon connection string in `.env`
3. Run `npm test` to verify database connectivity