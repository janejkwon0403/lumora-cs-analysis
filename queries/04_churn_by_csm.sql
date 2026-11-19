-- Question: Does churn rate differ by CSM?
-- Baseline: 18.4% churn (all 320 accounts)
-- Finding:  Highest is Ben Okafor at 25% (16 churned of 64 accounts)

SELECT c.csm_name AS grp,
       COUNT(*) AS accounts,
       SUM((a.status = 'Churned')::int) AS churned,
       ROUND(100 * AVG((a.status = 'Churned')::int), 1) AS churn_rate_pct
FROM accounts a
LEFT JOIN csm_reps c ON a.csm_id = c.csm_id
GROUP BY c.csm_name
ORDER BY churn_rate_pct DESC;