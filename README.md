# Customer Success Analytics: Lumora (SQL / PostgreSQL)

<!-- TODO: Replace this TL;DR once your findings are done (2–3 sentences: what you found + what you'd recommend). -->
**TL;DR:** _In progress._ Using SQL, I analyzed customers, support tickets, product usage and survey data for a SaaS company to find what drives customer churn and which accounts the Customer Success team should act on.

> **Note:** Lumora is a fictional company and all data is synthetic, generated for practice. No real customers or personal data are included.

---

## Business context

Lumora sells scheduling and invoicing software to small service businesses such as salons, fitness studios, dental clinics and tutoring centers. Customers pay per seat on one of three plans: **Starter**, **Growth** or **Scale**.

As a Customer Success analyst, I set out to answer questions a CS team asks every week:

- Which customers are leaving, and what do they have in common?
- Where does the support experience fall short, and does it affect retention?
- Which current customers need attention now?
- Where are the opportunities to help customers get more value?

The data snapshot is dated **2026-09-30**. All "recent" and "current" analysis is measured from that date.

## Dataset

| | |
|---|---|
| Accounts | 320 (261 active, 59 churned) |
| Support tickets | 3,373 |
| Monthly usage records | 4,581 (Jan 2025 – Sep 2026) |
| NPS survey responses | 605 |
| Tables | 11 |

Full column descriptions are in the **[data dictionary](docs/data_dictionary.md)**.

### Schema

```mermaid
erDiagram
    plans ||--o{ plan_features : includes
    features ||--o{ plan_features : "is in"
    plans ||--o{ accounts : "current plan"
    csm_reps ||--o{ accounts : manages
    accounts ||--o{ plan_changes : has
    accounts ||--|| onboarding : has
    accounts ||--o{ usage_monthly : logs
    accounts ||--o{ support_tickets : opens
    support_agents ||--o{ support_tickets : handles
    accounts ||--o{ nps_responses : answers

    accounts {
        int account_id PK
        varchar company_name
        varchar industry
        varchar region
        varchar company_size
        int plan_id FK
        int seats_purchased
        int csm_id FK
        date signup_date
        varchar status
        date churn_date
    }
    support_tickets {
        int ticket_id PK
        int account_id FK
        timestamp created_at
        varchar category
        varchar priority
        varchar channel
        int agent_id FK
        int first_response_minutes
        timestamp resolved_at
        int csat_score
    }
    usage_monthly {
        int account_id PK, FK
        date usage_month PK
        int seats
        int active_users
        int total_logins
    }
    onboarding {
        int account_id PK, FK
        date kickoff_call_date
        int training_sessions
        int onboarding_completed
        date completed_date
    }
    nps_responses {
        int response_id PK
        int account_id FK
        date survey_date
        int nps_score
    }
    plan_changes {
        int change_id PK
        int account_id FK
        date change_date
        int old_plan_id FK
        int new_plan_id FK
    }
```

The diagram exported from pgAdmin is in [`images/erd.png`](images/erd.png).

## Tools

- **PostgreSQL 18:** database
- **pgAdmin 4:** writing and running queries
- **Excel / Google Sheets:** charts <!-- TODO: update if you use something else -->
- **Git + GitHub Desktop:** version control

## Repository structure

```
lumora-cs-analysis/
├── README.md               ← you are here
├── findings.md             ← detailed findings log
├── setup/
│   ├── schema.sql          ← CREATE TABLE statements only (empty tables)
│   └── lumora_seed.sql     ← schema + all data (run this to rebuild everything)
├── queries/                ← one .sql file per question, numbered in order
├── docs/
│   └── data_dictionary.md  ← what every table and column means
└── images/                 ← schema diagram and charts
```

## Key findings

<!-- TODO: Add one section per finding. Template:

### 1. Headline that states the finding
One or two sentences explaining what the data shows, with the key number.

![Chart title](images/your_chart.png)

**Recommendation:** what the CS team should do about it.
**Query:** [queries/02_example.sql](queries/02_example.sql)
-->

_Analysis in progress. See [findings.md](findings.md) for the working log._

## Recommendations for the CS team

<!-- TODO: 3–5 concrete actions a CS manager could approve: who to contact, what to change, what to measure. -->

_Coming soon._

## How to reproduce

1. Install [PostgreSQL](https://www.postgresql.org/download/) (version 14 or newer).
2. Create a database:
   ```sql
   CREATE DATABASE lumora;
   ```
3. Load the schema and data. In pgAdmin, open the Query Tool on `lumora`, open `setup/lumora_seed.sql` and press F5. Or from psql:
   ```
   \c lumora
   \i setup/lumora_seed.sql
   ```
4. Verify:
   ```sql
   SELECT status, COUNT(*) FROM accounts GROUP BY status;
   -- Active 261, Churned 59
   ```
5. Run any file in [`queries/`](queries/).

The seed script uses portable SQL and also runs in MySQL 8+ and SQLite.

## Skills demonstrated

<!-- TODO: keep only what you actually used -->
- Multi-table `JOIN`s across customer, support, usage and survey data
- Aggregation and grouping (`GROUP BY`, `HAVING`, conditional `CASE` aggregates)
- Common table expressions (`WITH`)
- Window functions (`ROW_NUMBER`, `LAG`)
- Date and time analysis (`DATE_TRUNC`, intervals)
- Turning query results into business recommendations

## What I learned

<!-- TODO: 2–4 sentences. What was hardest? What surprised you? What would you analyze next? -->

---

**Author:** _Your Name_ · [LinkedIn](https://www.linkedin.com/in/your-profile) <!-- TODO -->
