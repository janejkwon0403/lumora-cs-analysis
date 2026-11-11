-- =====================================================================
--  Lumora (fictional) -- SCHEMA ONLY
--  Creates the 11 empty tables. To create AND fill them, run
--  setup/lumora_seed.sql instead (it contains this same schema).
--  Lumora is a scheduling + invoicing SaaS for small service businesses.
--  Data snapshot taken: 2026-09-30.
--  Portable SQL: runs in SQLite, PostgreSQL and MySQL 8+.
-- =====================================================================

DROP TABLE IF EXISTS nps_responses;
DROP TABLE IF EXISTS support_tickets;
DROP TABLE IF EXISTS usage_monthly;
DROP TABLE IF EXISTS onboarding;
DROP TABLE IF EXISTS plan_changes;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS plan_features;
DROP TABLE IF EXISTS features;
DROP TABLE IF EXISTS plans;
DROP TABLE IF EXISTS csm_reps;
DROP TABLE IF EXISTS support_agents;

CREATE TABLE plans (
    plan_id        INTEGER PRIMARY KEY,
    plan_name      VARCHAR(20) NOT NULL,
    monthly_price  DECIMAL(10,2) NOT NULL,   -- price per seat per month
    included_seats INTEGER NOT NULL          -- seats included before add-ons
);

CREATE TABLE features (
    feature_id   INTEGER PRIMARY KEY,
    feature_name VARCHAR(50) NOT NULL
);

CREATE TABLE plan_features (
    plan_id    INTEGER NOT NULL REFERENCES plans(plan_id),
    feature_id INTEGER NOT NULL REFERENCES features(feature_id),
    PRIMARY KEY (plan_id, feature_id)
);

CREATE TABLE csm_reps (
    csm_id    INTEGER PRIMARY KEY,
    csm_name  VARCHAR(50) NOT NULL,
    territory VARCHAR(30) NOT NULL
);

CREATE TABLE support_agents (
    agent_id   INTEGER PRIMARY KEY,
    agent_name VARCHAR(50) NOT NULL,
    hire_date  DATE NOT NULL
);

CREATE TABLE accounts (
    account_id     INTEGER PRIMARY KEY,
    company_name   VARCHAR(80) NOT NULL,
    industry       VARCHAR(40) NOT NULL,
    region         VARCHAR(30) NOT NULL,
    company_size   VARCHAR(10) NOT NULL,     -- employee band
    plan_id        INTEGER NOT NULL REFERENCES plans(plan_id),  -- CURRENT (or final) plan
    seats_purchased INTEGER NOT NULL,        -- current (or final) seat count
    csm_id         INTEGER NOT NULL REFERENCES csm_reps(csm_id),
    signup_date    DATE NOT NULL,
    status         VARCHAR(10) NOT NULL,     -- 'Active' or 'Churned'
    churn_date     DATE                      -- NULL if still active
);

CREATE TABLE plan_changes (
    change_id    INTEGER PRIMARY KEY,
    account_id   INTEGER NOT NULL REFERENCES accounts(account_id),
    change_date  DATE NOT NULL,
    old_plan_id  INTEGER NOT NULL REFERENCES plans(plan_id),
    new_plan_id  INTEGER NOT NULL REFERENCES plans(plan_id)
);

CREATE TABLE onboarding (
    account_id            INTEGER PRIMARY KEY REFERENCES accounts(account_id),
    kickoff_call_date     DATE,              -- NULL = kickoff never happened
    training_sessions     INTEGER NOT NULL,
    onboarding_completed  INTEGER NOT NULL,  -- 1 = yes, 0 = no
    completed_date        DATE
);

CREATE TABLE usage_monthly (
    account_id     INTEGER NOT NULL REFERENCES accounts(account_id),
    usage_month    DATE NOT NULL,            -- first day of month (data starts 2025-01)
    seats          INTEGER NOT NULL,         -- seats paid for that month
    active_users   INTEGER NOT NULL,         -- distinct users who logged in that month
    total_logins   INTEGER NOT NULL,
    PRIMARY KEY (account_id, usage_month)
);

CREATE TABLE support_tickets (
    ticket_id              INTEGER PRIMARY KEY,
    account_id             INTEGER NOT NULL REFERENCES accounts(account_id),
    created_at             TIMESTAMP NOT NULL,
    category               VARCHAR(30) NOT NULL,
    subject                VARCHAR(120) NOT NULL,
    priority               VARCHAR(10) NOT NULL,
    channel                VARCHAR(10) NOT NULL,
    agent_id               INTEGER NOT NULL REFERENCES support_agents(agent_id),
    first_response_minutes INTEGER NOT NULL,
    resolved_at            TIMESTAMP,
    status                 VARCHAR(10) NOT NULL,
    csat_score             INTEGER           -- 1-5, NULL = customer skipped survey
);

CREATE TABLE nps_responses (
    response_id INTEGER PRIMARY KEY,
    account_id  INTEGER NOT NULL REFERENCES accounts(account_id),
    survey_date DATE NOT NULL,
    nps_score   INTEGER NOT NULL             -- 0-10
);
