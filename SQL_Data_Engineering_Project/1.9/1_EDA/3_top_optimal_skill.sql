/*
Question : What are the most optimal skills for data engineers-balancing both demand and salary?
- Create a ranking column the combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries
- Why?
- This apporach highlights skills that balance market demand and financial reward.
It weights core skills appropriatedly, rather than letting rare, outlier skills distort the results.
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
   -- COUNT(jpf.salary_year_avg) AS demand_count,
    ROUND(LN(COUNT(jpf.*)), 1) AS demand_count,
    ROUND(MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*))/1_000_000, 2) AS optimal_skills
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
     jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = true
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY 
    sd.skills
HAVING 
    COUNT(jpf.*) > 100
ORDER BY
     optimal_skills DESC
LIMIT 25;


/*
Key Insights: Most Optimal Skills for Remote Data Engineers
- Terraform ranks as the most optimal skill, with the highest optimal score of 0.97 and a median annual salary of $184,000, demonstrating an excellent balance between salary and demand.

- Python and SQL are among the most valuable core skills, with optimal scores of 0.95 and 0.91, respectively. Both have the highest demand score of 7.0, highlighting their importance in remote Data Engineer positions.

- AWS ranks highly with an optimal score of 0.91 and a median salary of $137,320, indicating strong demand for cloud computing skills.

- Airflow and Spark also demonstrate a strong balance between demand and salary:
- Airflow: $150,000 median salary, 0.89 optimal score.
- Spark: $140,000 median salary, 0.87 optimal score.
- Snowflake and Kafka both achieve optimal scores of 0.82, highlighting the value of cloud data warehousing and real-time data processing skills.

- Kubernetes, despite offering a relatively high median salary of $150,500, has a lower optimal score of 0.75, suggesting that salary alone does not determine a skill's overall market value.
Overall Insight
Terraform, Python, SQL, AWS, and Airflow emerge as the top five optimal skills for remote Data Engineers with reported annual salaries. These skills offer the strongest combination of market demand and financial reward based on the ranking model.

Conclusion: Prioritising widely requested skills such as Python and SQL, alongside specialised technologies like Terraform, AWS, and Airflow, provides a practical career development strategy. This approach balances earning potential with employment opportunities rather than focusing only on the highest-paying skills.

┌────────────┬───────────────┬──────────────┬────────────────┐
│   skills   │ median_salary │ demand_count │ optimal_skills │
│  varchar   │    double     │    double    │     double     │
├────────────┼───────────────┼──────────────┼────────────────┤
│ terraform  │      184000.0 │          5.3 │           0.97 │
│ python     │      135000.0 │          7.0 │           0.95 │
│ sql        │      130000.0 │          7.0 │           0.91 │
│ aws        │      137320.0 │          6.7 │           0.91 │
│ airflow    │      150000.0 │          6.0 │           0.89 │
│ spark      │      140000.0 │          6.2 │           0.87 │
│ snowflake  │      135500.0 │          6.1 │           0.82 │
│ kafka      │      145000.0 │          5.7 │           0.82 │
│ azure      │      128000.0 │          6.2 │           0.79 │
│ java       │      135000.0 │          5.7 │           0.77 │
│ scala      │      137290.0 │          5.5 │           0.76 │
│ kubernetes │      150500.0 │          5.0 │           0.75 │
│ git        │      140000.0 │          5.3 │           0.75 │
│ databricks │      132750.0 │          5.6 │           0.74 │
│ redshift   │      130000.0 │          5.6 │           0.73 │
│ gcp        │      136000.0 │          5.3 │           0.72 │
│ nosql      │      134415.0 │          5.3 │           0.71 │
│ hadoop     │      135000.0 │          5.3 │           0.71 │
│ pyspark    │      140000.0 │          5.0 │            0.7 │
│ mongodb    │      135750.0 │          4.9 │           0.67 │
│ docker     │      135000.0 │          5.0 │           0.67 │
│ r          │      134775.0 │          4.9 │           0.66 │
│ go         │      140000.0 │          4.7 │           0.66 │
│ github     │      135000.0 │          4.8 │           0.65 │
│ bigquery   │      135000.0 │          4.8 │           0.65 │
└────────────┴───────────────┴──────────────┴────────────────┘
  25 rows                                          4 columns

*/