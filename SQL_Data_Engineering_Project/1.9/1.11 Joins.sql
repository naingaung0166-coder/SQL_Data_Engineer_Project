SELECT
    jpf.job_id,
    cd.name AS company_name,
    cd.company_id,
    jpf.job_title_short,
    jpf.job_location
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
ON jpf.company_id = cd.company_id
LIMIT 10;

SELECT
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id
-- sd.skill_name
FROM job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd
ON jpf.job_id = sjd.job_id;

SELECT
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id
-- sd.skill_name
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
ON jpf.job_id = sjd.job_id;


/*
Find the top 10 companies with the most job postings in the job_postings_fact table.
Limit only in US jobs
They must have at least 3000 job postings
 */
 
EXPLAIN ANALYZE
SELECT
    cd.name AS company_name,
    COUNT(jpf.*) AS job_postings_count
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
ON jpf.company_id = cd.company_id
--WHERE jpf.job_location LIKE '%United States%'
WHERE jpf.job_country = 'United States'
GROUP BY cd.name
HAVING COUNT(jpf.*) >= 3000
ORDER BY job_postings_count DESC
LIMIT 10;