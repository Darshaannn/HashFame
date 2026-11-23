# GGs Privacy & Legal Readiness Checklist

> [!IMPORTANT]
> **LEGAL NOTICE & DISCLAIMER:**  
> The policies and checklists in this document reflect the technical implementation and data flows of the GGs application (repository: `Darshaannn/HashFame`). This document does not constitute formal legal counsel. Before public deployment or commercial launch, all terms and privacy policies must be reviewed and approved by a qualified legal professional specializing in Indian IT law, the Digital Personal Data Protection Act (DPDP), and platform terms.

---

## 1. Regulatory & Platform Compliance Scope

1. **Indian Digital Personal Data Protection Act (DPDP Act 2023):**
   - Explicit consent mechanisms for processing creator contact details.
   - Purpose limitation for business outreach.
   - Right to access, correction, and account/data erasure.
2. **Meta Platform & Developer Policies:**
   - Compliance with Instagram Graph API usage rules.
   - No unauthorized scraping or caching of private user data.
   - Clear OAuth authorization and secure token vault storage.
3. **Google Play Store Data Safety:**
   - Accurate disclosures of data collected (Email, User Identifiers, Device IDs).
   - Working in-app and web-based account deletion URL.

---

## 2. Privacy Policy Core Requirements

The GGs Privacy Policy must explicitly state:
- **Data Collected:**
  - *Account Info:* Email address, full name, role (Brand, Agency, Creator).
  - *Creator Profile Data:* Niche categories, primary city, bio, portfolio links.
  - *Authorized Instagram Data:* Instagram username, user ID, authorized follower count, and public media URLs obtained strictly via Meta Graph API OAuth.
  - *Optional Contact Preferences:* Business email, WhatsApp number, and phone number (only stored and exposed when explicitly enabled by the creator).
- **How Data Is Used:**
  - Enabling search discovery and matching between brands and creators.
  - Facilitating private quotation requests and milestone deliverable tracking.
  - Authenticating sessions via Supabase Auth and email OTP.
- **Data Sharing:**
  - GGs **never sells user data** or contact details to third-party data brokers.
  - Contact information is only visible to logged-in, authenticated brands/agencies when authorized by the creator.
- **Data Retention & Erasure:**
  - Users have the right to delete their profile and associated data at any time via Settings -> Delete Account.

---

## 3. Terms of Service Key Provisions

1. **Marketplace Role:** GGs is a discovery and collaboration facilitation tool. GGs is not an employer, talent agent, or direct party to commercial contracts negotiated between brands and creators.
2. **No Rate Card Guarantee:** All pricing is negotiated privately between creators and brands. GGs does not guarantee deal closure, response times, or minimum earnings.
3. **User Conduct:** Prohibits harassment, fraudulent campaigns, impersonation, spam outreach, and intellectual property infringement.
4. **Dispute Resolution & Jurisdiction:** Governed by the laws of India, with jurisdiction in [City/State of incorporation, e.g. Mumbai, Maharashtra].

---

## 4. Account & Data Deletion Workflow

- **In-App Trigger:** Users can request deletion under `Settings -> Account -> Delete Account`.
- **Backend Execution:** Calls Supabase cascading deletion or flags user for hard purge, removing profile records, contact preferences, and cached Instagram tokens.
- **Web-Based URL:** Google Play Console requires a publicly accessible web URL where users can request data deletion without having the app installed (e.g. `https://ggs.app/privacy/delete-request`).

---

## 5. Items Requiring Owner Input

The following details must be provided by the project owner before publishing legal drafts:
- [ ] Official Legal Entity Name (e.g. Private Limited or Sole Proprietorship).
- [ ] Registered Company Office Address.
- [ ] Designated Grievance Officer Name, Email, and Postal Address (mandatory under Indian Information Technology Rules).
- [ ] Official Support & Privacy Email (e.g. `support@hashfame.in` or `privacy@ggs.app`).
