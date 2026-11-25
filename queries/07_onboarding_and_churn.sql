-- Question: Do customers who don't complete onboarding churn more?
-- Finding:  Yes. Not completed: 50.0% churn (35 of 70). Completed: 9.6% (24 of 250).
--           Baseline 18.4%. About 22 more churned than expected.

SELECT o.onboarding_completed AS grp,
       COUNT(*) AS accounts,
       SUM((a.status = 'Churned')::int) AS churned,
       ROUND(100 * AVG((a.status = 'Churned')::int), 1) AS churn_rate_pct
FROM accounts a
JOIN onboarding o ON o.account_id = a.account_id
GROUP BY grp
ORDER BY grp;

-- Question: Is a missing kickoff call where the onboarding problem starts?
-- Finding: Partly. All 49 accounts with no kickoff call never completed onboarding, so the kickoff is the first step. 
-- 			But the 21 who had a kickoff and still didn't finish churned about the same (47.6% vs 51.0%). 
-- 			Finishing onboarding is what matters most for churn.
SELECT CASE WHEN o.kickoff_call_date IS NULL THEN 'No kickoff'
            ELSE 'Had kickoff' END AS kickoff,
       o.onboarding_completed AS completed,
       COUNT(*) AS accounts,
       SUM((a.status = 'Churned')::int) AS churned,
       ROUND(100 * AVG((a.status = 'Churned')::int), 1) AS churn_rate_pct
FROM accounts a
JOIN onboarding o ON o.account_id = a.account_id
GROUP BY kickoff, completed
ORDER BY kickoff, completed;

-- Query 3: Does the onboarding gap still show up inside each plan?
-- Finding: Yes. Within every plan, customers who didn't complete onboarding churn far more.
--          Growth Plan: 39.5% vs 2.9%, Starter Plan: 66.7% vs 19.1%. Scale Plan is too small to judge (5 accounts).
SELECT pl.plan_name,
       o.onboarding_completed AS completed,
       COUNT(*) AS accounts,
       SUM((a.status = 'Churned')::int) AS churned,
       ROUND(100 * AVG((a.status = 'Churned')::int), 1) AS churn_rate_pct
FROM accounts a
JOIN onboarding o ON o.account_id = a.account_id
JOIN plans pl ON pl.plan_id = a.plan_id
GROUP BY pl.plan_name, completed
ORDER BY pl.plan_name, completed;