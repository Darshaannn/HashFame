# GGs Customer Support & Operations Playbook

## 1. Support Principles & Channels

During Closed Beta, support must be human, responsive, and systematic.
- **Primary Support Channels:**
  - Dedicated WhatsApp Beta Support Line (monitored during business hours: 10:00 AM – 7:00 PM IST).
  - Support Email: `support@hashfame.in` (or configured project email).
  - In-App "Report / Feedback" button.

---

## 2. Standard Operating Procedures (SOPs)

### SOP 01: OTP Not Received / Login Failure
- **User Experience:** User enters email on login screen but does not receive the 6-digit verification code.
- **Internal Severity:** `P1` (High)
- **Triage Steps:**
  1. Advise user to check **Spam / Promotions** folder for emails from `no-reply@hashfame.in` (Brevo SMTP).
  2. Verify if user email domain blocks transactional emails.
  3. Check Supabase Auth Dashboard logs for Brevo delivery status or rate limits.
  4. If delivery fails persistently, provision a manual one-time bypass or whitelist email in staging auth.

---

### SOP 02: Creator Cannot Connect Instagram
- **User Experience:** Creator taps "Connect Instagram", but receives an error or cannot see their media grid.
- **Internal Severity:** `P2` (Medium)
- **Triage Steps:**
  1. Confirm creator has an **Instagram Professional (Creator or Business) Account**, not a personal account (Meta Graph API requires professional accounts linked to a Facebook Page).
  2. Verify whether creator's Meta account has accepted required permissions (`instagram_basic`, `pages_show_list`).
  3. If in Meta Development Mode, ensure the creator's Facebook profile is added to the **App Roles -> Test Users / Testers** in the Meta Developer Portal.

---

### SOP 03: Request Not Answered by Creator
- **User Experience:** Brand sends a contact request or quotation request, but receives no response after 72 hours.
- **Internal Severity:** `P3` (Low / Operational)
- **Triage Steps:**
  1. Check whether the recipient is a **Directory Profile** (unclaimed) or a **Registered Creator**.
  2. If Directory Profile: Remind brand that this is a curated record; offer assistance reaching out via published business email.
  3. If Registered Creator: Check if creator's notification email was sent. Send a friendly WhatsApp reminder via the GGs Community Manager.

---

### SOP 04: Incorrect Directory or Profile Information
- **User Experience:** An influencer or agency flags that follower numbers, location, or bio in the directory is outdated or inaccurate.
- **Internal Severity:** `P2` (Medium)
- **Triage Steps:**
  1. Verify the correct details directly from the creator's live Instagram profile.
  2. Update the record in `creator_directory` table in Supabase via safe migration script or admin update.
  3. Notify the reporter within 24 hours of correction.

---

### SOP 05: Suspicious Account or Abuse Report
- **User Experience:** User reports spam outreach, inappropriate content, or fraudulent campaign terms.
- **Internal Severity:** `P1` (High)
- **Triage Steps:**
  1. Temporarily restrict reported account's ability to send contact requests.
  2. Inspect chat logs and campaign details.
  3. Contact both parties for clarification.
  4. Permanently terminate account if spam, harassment, or fraudulent activity is confirmed.
