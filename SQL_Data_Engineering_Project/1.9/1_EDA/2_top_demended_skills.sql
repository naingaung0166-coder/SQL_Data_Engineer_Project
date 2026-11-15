/* 
Question : What are the highest paying skills for data engineers?
- Calculate the median salary for each skill required for data engineer positions.
- Focus on remote positions with specific salary ranges in job postings for data engineers.
- Include skill frequency to identify both salary and demand.
- Why? Helps identify which skills command the highest compensation while also showing 
how common those skills are, providing a more complete picture for skill development priorities.
  
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Engineer'
AND jpf.job_work_from_home = true
GROUP BY sd.skills
HAVING COUNT(jpf.*) > 100
ORDER BY median_salary DESC
LIMIT 25;

/*
Here's a breakdown of the highest-paying skills for Data Engineers:

Key Insights:
- Rust is the highest-paying skill, with a median salary of $210k, although demand is relatively limited at 232 job postings.

- Terraform and Golang both offer high median salaries of $184k, but Terraform has significantly higher demand (3,248 postings) compared with Golang (912 postings).

- Airflow has the highest demand among all 25 skills, with 9,996 job postings and a competitive median salary of $150k, making it particularly attractive in the job market.

- Kubernetes also demonstrates strong market demand, with 4,202 postings and a median salary of $150.5k, highlighting the importance of cloud infrastructure and containerisation skills.

- Other notable skills offering high salaries with moderate demand include:
- Spring: $175.5k median salary, 364 postings.
- Neo4j: $170k median salary, 277 postings.
- GDPR: $169.6k median salary, 582 postings.
- GraphQL: $167.5k median salary, 445 postings.
- FastAPI: $157.5k median salary, 204 postings.
- Overall Insight: While Rust offers the highest median salary, Airflow, Kubernetes, and Terraform provide a stronger combination of high salaries and job demand, making them valuable skills to prioritise for career development.


┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ rust       │      210000.0 │          232 │
│ golang     │      184000.0 │          912 │
│ terraform  │      184000.0 │         3248 │
│ spring     │      175500.0 │          364 │
│ neo4j      │      170000.0 │          277 │
│ gdpr       │      169616.0 │          582 │
│ zoom       │      168438.0 │          127 │
│ graphql    │      167500.0 │          445 │
│ mongo      │      162250.0 │          265 │
│ fastapi    │      157500.0 │          204 │
│ bitbucket  │      155000.0 │          478 │
│ django     │      155000.0 │          265 │
│ crystal    │      154224.0 │          129 │
│ atlassian  │      151500.0 │          249 │
│ c          │      151500.0 │          444 │
│ typescript │      151000.0 │          388 │
│ kubernetes │      150500.0 │         4202 │
│ node       │      150000.0 │          179 │
│ ruby       │      150000.0 │          736 │
│ airflow    │      150000.0 │         9996 │
│ css        │      150000.0 │          262 │
│ redis      │      149000.0 │          605 │
│ vmware     │      148798.0 │          136 │
│ ansible    │      148798.0 │          475 │
│ jupyter    │      147500.0 │          400 │
└────────────┴───────────────┴──────────────┘
  25 rows                         3 columns
*/

