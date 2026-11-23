# GGs Beta Feedback System & QA Monitoring

## 1. Zero-Cost Feedback Collection Process

During the Closed Beta, feedback will be gathered using zero-cost, lightweight tools:
1. **Google Forms / Typeform (Free tier)** for weekly structured surveys.
2. **Dedicated WhatsApp Beta Community / 1-on-1 Chats** for immediate blocker reporting.
3. **Structured Spreadsheet (`tester-tracker.csv`)** for qualitative logging and status tracking.

---

## 2. Role-Specific Structured Questionnaires

### 2.1 Creator Feedback Questionnaire (Post-Onboarding & Inquiry)
*Sent after 7 days of onboarding or upon receiving the first contact request.*

1. **Account Setup & Profile:**
   - How smooth was the email OTP sign-in? `[1: Confusing - 5: Instant & Easy]`
   - Were you able to select your accurate niches and city easily? `[Yes / No / Notes]`
   - Did you connect your Instagram account? If no, what held you back?
2. **Contact Preferences & Privacy:**
   - Did you feel in control of which contact details (WhatsApp/Email) were shared with brands?
3. **Quotation Workflow:**
   - Was the process of submitting a private quotation clear? `[1: Unclear - 5: Very Intuitive]`
   - Did you prefer submitting a custom quote over having a fixed public rate card?
4. **General Feedback:**
   - What was the most frustrating part of using GGs?
   - What one feature would make you check GGs every single morning?

---

### 2.2 Brand & Agency Feedback Questionnaire
*Sent after completing first search, shortlist, and contact request.*

1. **Discovery & Search:**
   - Did the natural-language search return relevant creators for your campaign needs? `[1: Irrelevant - 5: Spot On]`
   - Were the follower tiers and location filters accurate?
2. **Shortlists & Outreach:**
   - Did you find the shortlist comparison helpful for decision-making?
   - How clear was the difference between registered creators and directory listings?
3. **Quotation Experience:**
   - Did receiving a private quotation from the creator meet your timeline expectations?
   - Would your team use GGs over manual Instagram searching for your next campaign?
4. **Friction & Gaps:**
   - Did you encounter any bugs, crashes, or confusing screens?

---

## 3. Bug Reporting Specification Form

When a beta tester reports an issue, capture the following fields:

| Field Name | Description / Options |
| :--- | :--- |
| **Reporter Role** | `Brand` / `Agency` / `Creator` / `Internal QA` |
| **Device Model & OS** | e.g. Samsung Galaxy S23 (Android 14) / OnePlus 11 (Android 13) |
| **App Version** | e.g. `v0.8.0-beta (build 8)` |
| **Screen / Flow** | `Login`, `Search`, `Profile`, `Contact Bottom Sheet`, `Quotation Form`, `Chat` |
| **Issue Severity** | `P0 (Crash / Blocker)`, `P1 (Feature Broken)`, `P2 (Usability Flaw)`, `P3 (Visual/Copy Typo)` |
| **Steps to Reproduce** | 1. Go to Search... 2. Type... 3. Click... |
| **Expected Behavior** | What should have occurred. |
| **Actual Behavior** | What actually happened (include error text or screenshot if available). |

---

## 4. Weekly Feedback Synthesis Template

At the end of each beta week, the Product Manager compiles this summary:

```markdown
# GGs Closed Beta Weekly Summary — Week [X]

## 1. Funnel Metrics
- Active Testers: [X] Creators | [Y] Brands/Agencies
- Total Searches Run: [X]
- Shortlists Created: [X]
- Contact Requests Dispatched: [X]
- Private Quotations Submitted: [X]
- In-App Conversations Started: [X]

## 2. Top 3 User Friction Points
1. [Friction point description + user quote]
2. [Friction point description + user quote]
3. [Friction point description + user quote]

## 3. Bug Resolution Tracker
- P0 Blockers Resolved: [X]
- P1 Defects Pending: [Y]
- Usability Tweaks Scheduled: [Z]

## 4. Recommendations for Next Sprint
- [Action item 1]
- [Action item 2]
```
