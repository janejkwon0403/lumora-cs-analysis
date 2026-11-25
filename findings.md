# Lumora Customer Success Findings
## Baseline (all customers, as of 2026-09-30)

Query: `queries/01_baseline.sql`

| Metric | Value |
|---|---|
| Accounts | 320 (261 Active / 59 Churned) |
| Churn rate | 18.4% |
| Onboarding completion rate | 78.4% |
| Average CSAT (answered surveys) | 3.97 |
| CSAT 4–5 share (answered surveys) | 73.9% |
| NPS | -14.1 (Promoters 24.6%, Detractors 38.7%) |
| First response within 1 hour | 2160 of 3,373 tickets |


## Findings

### Finding 1: Customers who don't complete onboarding churn at 50%, five times the rate of those who do (9.6%)

**Question:** Do customers who don't complete onboarding churn more?
**Query:** `queries/07_onboarding_and_churn.sql`

| Onboarding | Accounts | Churned | Churn % |
|---|---|---|---|
| Completed | 250 | 24 | 9.6% |
| Not completed | 70 | 35 | 50.0% |

Baseline: 18.4%

**What else I found:**
- All 49 accounts that never had a kickoff call also never completed onboarding.
- The 21 accounts that had a kickoff call but didn't finish churned about the same (47.6%) as those with no kickoff (51.0%). Finishing onboarding is what matters most.
- The gap shows up within every plan (Growth 39.5% vs 2.9%, Starter 66.7% vs 19.1%).

**Checks:**
- 70 customers didn't finish onboarding, so this isn't based on just a few accounts.
- If these 70 churned at the normal rate, I'd expect about 13 to leave. 35 left, which is about 22 more than normal.
- I checked whether the plan explained it. It didn't. In every plan, customers who didn't finish onboarding churned much more.

**Why it might happen:** Customers who don't finish onboarding never learn to use the platform to its full capabilities, so they don't see enough value to stay.

**What CS should do:**
1. Make sure every new customer has a kickoff call (49 never did).
2. Follow up when onboarding stalls after the kickoff (21 customers started but didn't finish).