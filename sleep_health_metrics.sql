/*
Created by: Brandy Nolan
Created On: August 30, 2024
Description: Kaggle dataset designed to provide an extensive overview of how various factors might influence sleep quality and overall health. 
*/

-- Summary of sleep duration 
SELECT 
	MIN(`Sleep_Duration_Hours`) least_sleep,
    MAX(`Sleep_Duration_Hours`) most_sleep,
	ROUND(AVG(`Sleep_Duration_Hours`),0) avg_sleep
FROM 
	`sleep`;
    
-- Creating a column which breaks the participants into 2 categories (Above_avg_sleep_duration and below_avg_sleep_duration).
WITH my_cte AS (
    SELECT 
        *,
        CASE 
            WHEN `Sleep_Duration_Hours` >= (SELECT AVG(`Sleep_Duration_Hours`) FROM `sleep`) THEN 'Above_avg_sleep_duration'
            ELSE 'Below_avg_sleep_duration'
        END AS `Sleep Duration vs. Average`
    FROM 
        `sleep`
)
SELECT
    `Sleep Duration vs. Average`,
    COUNT(*) AS `Count`
FROM 
    my_cte
GROUP BY 
    `Sleep Duration vs. Average`

-- Summary statics by Sleep Duration vs. Average
WITH my_cte AS (
    SELECT 
        *,
        CASE 
            WHEN `Sleep_Duration_Hours` >= (SELECT AVG(`Sleep_Duration_Hours`) FROM `sleep`) THEN 'Above_avg_sleep_duration'
            ELSE 'Below_avg_sleep_duration'
        END AS `Sleep Duration vs. Average`
    FROM 
        `sleep`
)
SELECT 
    `Sleep Duration vs. Average`, 
    ROUND(AVG(`Heart_Rate_Variability`),2) avg_heart_rate,
    ROUND(AVG(`Body_Temperature`),2) avg_body_temp,
    ROUND(AVG(`Movement_During_Sleep`),2) avg_movement,
    ROUND(AVG(`Sleep_Quality_Score`),2) avg_sleep_quality,
    ROUND(AVG(`Caffeine_Intake_mg`),2) avg_caffeine_intake,
    ROUND(AVG(`Stress_Level`),2) avg_stress_level,
    ROUND(AVG(`Bedtime_Consistency`),2) avg_bedtime_consistency,
    ROUND(AVG(`Light_Exposure_hours`),2) avg_light_exposure
FROM 
    my_cte
GROUP BY 
    `Sleep Duration vs. Average`;

