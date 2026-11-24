-- Question: How did total active users change month over month?
-- Finding:  Total active users grew from 806 (Jan 2025) to 1,931 (Sep 2026).
--           Note: this total includes new customers signing up over time, so growth here does not prove each account is using Lumora more.
WITH usage_per_month AS (
    SELECT DATE_TRUNC('month', usage_month)::date AS month,
           SUM(active_users) AS total_active_users
    FROM usage_monthly
    GROUP BY month
)
SELECT month, total_active_users,
       total_active_users - LAG(total_active_users) OVER (ORDER BY month) AS change_vs_last_month
FROM usage_per_month
ORDER BY month;