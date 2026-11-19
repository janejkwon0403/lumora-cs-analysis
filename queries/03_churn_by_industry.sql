-- Question: Does churn rate differ by industry?
-- Baseline: 18.4% churn (all 320 accounts)
-- Finding:  Highest is Legal Services at 29.5% (13 churned of 44 accounts)

SELECT industry AS grp,
       COUNT(*) AS accounts,
       SUM((status = 'Churned')::int) AS churned,
       ROUND(100 * AVG((status = 'Churned')::int), 1) AS churn_rate_pct
FROM accounts
GROUP BY industry
ORDER BY churn_rate_pct DESC;