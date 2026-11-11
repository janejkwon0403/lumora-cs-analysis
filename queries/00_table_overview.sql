-- Question: How many rows does each main table have?
-- Finding:  320 accounts, 3,373 support tickets, 4,581 monthly usage records.

SELECT 'accounts' AS table_name, COUNT(*) FROM accounts
UNION ALL SELECT 'support_tickets', COUNT(*) FROM support_tickets
UNION ALL SELECT 'usage_monthly', COUNT(*) FROM usage_monthly;

-- Result:
-- table_name       | count
-- -----------------+------
-- accounts         |   320
-- support_tickets  |  3373
-- usage_monthly    |  4581
