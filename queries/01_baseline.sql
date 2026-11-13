-- Question: What percent of accounts have churned?
-- Finding:  18.4%
SELECT ROUND(100 * AVG((status = 'Churned')::int), 1) AS churn_rate_pct
FROM accounts;

-- Question: What percent of accounts completed onboarding?
-- Finding:  78.4%
SELECT ROUND(100 * AVG(onboarding_completed), 1) AS onboarding_completion_pct
FROM onboarding;

-- Question: What is the average CSAT score (answered surveys only)?
-- Finding:  3.97
SELECT ROUND(AVG(csat_score), 2) AS avg_csat
FROM support_tickets;

-- Question: Of answered surveys, what percent scored 4 or 5?
-- Finding:  73.9%
SELECT ROUND(100 * AVG(CASE WHEN csat_score >= 4 THEN 1 ELSE 0 END), 1) AS csat_4_5_pct
FROM support_tickets
WHERE csat_score IS NOT NULL;

-- Question: What is Lumora's NPS?
-- Finding:  Promoters 24.6%, Detractors 38.7%, NPS -14.0
SELECT ROUND(100 * AVG(CASE WHEN nps_score >= 9 THEN 1 ELSE 0 END), 1) AS promoters_pct,
       ROUND(100 * AVG(CASE WHEN nps_score <= 6 THEN 1 ELSE 0 END), 1) AS detractors_pct,
       ROUND(100 * AVG(CASE WHEN nps_score >= 9 THEN 1 ELSE 0 END)
           - 100 * AVG(CASE WHEN nps_score <= 6 THEN 1 ELSE 0 END), 1) AS nps
FROM nps_responses;

-- Question: How quickly does support first respond to tickets?
-- Finding:  Within 1 hour: 2160, Within 4 hours: 728, Slower: 485, No response: 0
SELECT CASE
         WHEN first_response_minutes IS NULL THEN 'No response'
         WHEN first_response_minutes <= 60   THEN 'Within 1 hour'
         WHEN first_response_minutes <= 240  THEN 'Within 4 hours'
         ELSE 'Slower'
       END AS speed,
       COUNT(*) AS tickets
FROM support_tickets
GROUP BY speed;