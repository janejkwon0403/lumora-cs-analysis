-- Question: Does churn rate differ by plan?
-- Baseline: 18.4% churn (all 320 accounts)
-- Finding:  Highest is Starter at 29.8% (36 churned of 121 accounts)

SELECT pl.plan_name AS grp,
       COUNT(*) AS accounts,
       SUM((a.status = 'Churned')::int) AS churned,
       ROUND(100 * AVG((a.status = 'Churned')::int), 1) AS churn_rate_pct
FROM accounts a
JOIN plans pl ON a.plan_id = pl.plan_id
GROUP BY pl.plan_name
ORDER BY churn_rate_pct DESC;