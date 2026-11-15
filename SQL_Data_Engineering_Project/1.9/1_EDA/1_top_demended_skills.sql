/* 
Question : What are the most in-demand skills for data engineers?
- Identify the top 10 skills that are most frequently mentioned in job postings for data engineers.
- Focus on remote job postings
- Why ? Retrieves the top 10 skills with the highest demand in the remote job
   providing insights into the most valuable skills

*/

SELECT
    sd.skills,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Engineer'
AND jpf.job_work_from_home = true
GROUP BY sd.skills
ORDER BY demand_count DESC
LIMIT 10;

/*
Here is the breakdown of the most demanded skills for  data engineer:
SQL and Python are by the most in-demand skills , with around 29000 job postings each. SQL is a fundamental skill for data engineers, as it is used for querying and manipulating data in relational databases. Python is also a popular programming language for data engineering tasks, such as data cleaning, transformation, and analysis.
Cloud platforms round out the top skills, with AWS leading at -10000 postings , followed by Azure at -14,000
Apache Spark completes the top 5 skills with around 12,000 postings, while Airflow and Snowflake are also in high demand with around 10,000 and 8,000 postings respectively.

KEY INSIGHTS:
- SQL and Python are the most in-demand skills for data engineers, with around 29,000 job postings each.
- Cloud platforms such as AWS, Azure, and GCP are also highly sought after, indicating the importance of cloud computing skills for data engineers.
- Big data tools like Apache Spark and Airflow are also in high demand, indicating the importance of data processing and workflow management skills for data engineers.
- Data pipeline tools like Airflow and Snowflake are also in high demand, indicating the importance of data processing and workflow management skills for data engineers.
- Java and GCP round out the top 10 skills, with around 7,000 and 6,000 postings respectively, indicating that proficiency in programming languages and cloud platforms is also important for data engineers.



┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
└────────────┴──────────────┘
  10 rows         2 columns
*/