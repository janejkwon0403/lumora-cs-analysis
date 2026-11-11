# Data Dictionary

All data is synthetic. Snapshot date: **2026-09-30**.

## accounts
One row per customer company.

| Column | Type | Description |
|---|---|---|
| account_id | integer, PK | Unique account ID |
| company_name | varchar(80) | Company name |
| industry | varchar(40) | Business type (e.g. Salon & Spa, Dental Clinic, Tutoring) |
| region | varchar(30) | North America, EMEA or APAC |
| company_size | varchar(10) | Employee band: 1-10, 11-50, 51-200 |
| plan_id | integer, FK → plans | **Current** plan (or final plan, if churned) |
| seats_purchased | integer | Current (or final) number of paid seats |
| csm_id | integer, FK → csm_reps | Assigned Customer Success Manager |
| signup_date | date | Date the account started |
| status | varchar(10) | `Active` or `Churned` |
| churn_date | date | Date the account cancelled; NULL if active |

## plans
| Column | Type | Description |
|---|---|---|
| plan_id | integer, PK | 1 = Starter, 2 = Growth, 3 = Scale |
| plan_name | varchar(20) | Plan name |
| monthly_price | decimal(10,2) | Price per seat per month (USD) |
| included_seats | integer | Seats included in the base plan |

## features
| Column | Type | Description |
|---|---|---|
| feature_id | integer, PK | Unique feature ID |
| feature_name | varchar(50) | Feature name |

## plan_features
Which features each plan includes (many-to-many).

| Column | Type | Description |
|---|---|---|
| plan_id | integer, PK, FK → plans | Plan |
| feature_id | integer, PK, FK → features | Feature included in that plan |

## plan_changes
One row each time an account switched plans.

| Column | Type | Description |
|---|---|---|
| change_id | integer, PK | Unique change ID |
| account_id | integer, FK → accounts | Account that changed plan |
| change_date | date | Date of the change |
| old_plan_id | integer, FK → plans | Plan before |
| new_plan_id | integer, FK → plans | Plan after |

## onboarding
One row per account describing its setup period.

| Column | Type | Description |
|---|---|---|
| account_id | integer, PK, FK → accounts | Account |
| kickoff_call_date | date | Date of the kickoff call; NULL = never happened |
| training_sessions | integer | Number of training sessions attended |
| onboarding_completed | integer | 1 = completed, 0 = not completed |
| completed_date | date | Date onboarding was completed; NULL if not |

## usage_monthly
One row per account per month, starting January 2025.

| Column | Type | Description |
|---|---|---|
| account_id | integer, PK, FK → accounts | Account |
| usage_month | date, PK | First day of the month |
| seats | integer | Seats paid for that month |
| active_users | integer | Distinct users who logged in that month |
| total_logins | integer | Total logins that month |

## support_tickets
One row per support ticket.

| Column | Type | Description |
|---|---|---|
| ticket_id | integer, PK | Unique ticket ID |
| account_id | integer, FK → accounts | Account that opened the ticket |
| created_at | timestamp | When the ticket was opened |
| category | varchar(30) | Integrations, Reporting, Billing, Bug, How-to, Account Access, Onboarding |
| subject | varchar(120) | Ticket subject line |
| priority | varchar(10) | Low, Medium, High, Urgent |
| channel | varchar(10) | Email, Chat, Phone |
| agent_id | integer, FK → support_agents | Agent who handled the ticket |
| first_response_minutes | integer | Minutes until the first reply |
| resolved_at | timestamp | When the ticket was resolved; NULL if open |
| status | varchar(10) | Open or Closed |
| csat_score | integer | Customer satisfaction 1–5; NULL = survey skipped |

## support_agents
| Column | Type | Description |
|---|---|---|
| agent_id | integer, PK | Unique agent ID |
| agent_name | varchar(50) | Agent name |
| hire_date | date | Date hired |

## csm_reps
| Column | Type | Description |
|---|---|---|
| csm_id | integer, PK | Unique CSM ID |
| csm_name | varchar(50) | CSM name |
| territory | varchar(30) | Territory covered |

## nps_responses
One row per Net Promoter Score survey answer (roughly every 6 months per account).

| Column | Type | Description |
|---|---|---|
| response_id | integer, PK | Unique response ID |
| account_id | integer, FK → accounts | Account that answered |
| survey_date | date | Survey date |
| nps_score | integer | 0–10. 9–10 = promoter, 7–8 = passive, 0–6 = detractor |
