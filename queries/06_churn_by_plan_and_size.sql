-- Question: Is Starter's high churn explained by company size?
-- Finding:  No. Within 1-10 and 11-50 companies, Starter still churns far more(30.6% and 37.5%) than Growth (12.3% and 14.3%). Among 51-200companies, Starter is near baseline (18.8%). Scale 51-200 is too small to judge (11 accounts).

SELECT pl.plan_name,
       a.company_size AS second_grp,
       COUNT(*) AS accounts,
       SUM((a.status = 'Churned')::int) AS churned,
       ROUND(100 * AVG((a.status = 'Churned')::int), 1) AS churn_rate_pct
FROM accounts a
JOIN plans pl ON a.plan_id = pl.plan_id
GROUP BY pl.plan_name, second_grp
ORDER BY second_grp, churn_rate_pct DESC;