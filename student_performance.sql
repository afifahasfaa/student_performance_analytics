-- Structure of Data
DESCRIBE studentperformancefactors;

-- Check missing values
SELECT
    SUM(Hours_Studied IS NULL OR TRIM(Hours_Studied) = '') AS Hours_Studied,
    SUM(Attendance IS NULL OR TRIM(Attendance) = '') AS Attendance,
    SUM(Parental_Involvement IS NULL OR TRIM(Parental_Involvement) = '') AS Parental_Involvement,
    SUM(Access_to_Resources IS NULL OR TRIM(Access_to_Resources) = '') AS Access_to_Resources,
    SUM(Extracurricular_Activities IS NULL OR TRIM(Extracurricular_Activities) = '') AS Extracurricular_Activities,
    SUM(Sleep_Hours IS NULL OR TRIM(Sleep_Hours) = '') AS Sleep_Hours,
    SUM(Previous_Scores IS NULL OR TRIM(Previous_Scores) = '') AS Previous_Scores,
    SUM(Motivation_Level IS NULL OR TRIM(Motivation_Level) = '') AS Motivation_Level,
    SUM(Internet_Access IS NULL OR TRIM(Internet_Access) = '') AS Internet_Access,
    SUM(Tutoring_Sessions IS NULL OR TRIM(Tutoring_Sessions) = '') AS Tutoring_Sessions,
    SUM(Family_Income IS NULL OR TRIM(Family_Income) = '') AS Family_Income,
    SUM(Teacher_Quality IS NULL OR TRIM(Teacher_Quality) = '') AS Teacher_Quality,
    SUM(School_Type IS NULL OR TRIM(School_Type) = '') AS School_Type,
    SUM(Peer_Influence IS NULL OR TRIM(Peer_Influence) = '') AS Peer_Influence,
    SUM(Physical_Activity IS NULL OR TRIM(Physical_Activity) = '') AS Physical_Activity,
    SUM(Learning_Disabilities IS NULL OR TRIM(Learning_Disabilities) = '') AS Learning_Disabilities,
    SUM(Parental_Education_Level IS NULL OR TRIM(Parental_Education_Level) = '') AS Parental_Education_Level,
    SUM(Distance_from_Home IS NULL OR TRIM(Distance_from_Home) = '') AS Distance_from_Home,
    SUM(Gender IS NULL OR TRIM(Gender) = '') AS Gender,
    SUM(Exam_Score IS NULL OR TRIM(Exam_Score) = '') AS Exam_Score
FROM studentperformancefactors;

-- Solving missing values
SET SQL_SAFE_UPDATES = 0;
UPDATE studentperformancefactors
SET Teacher_Quality = COALESCE(Teacher_Quality, 'Unknown'),
    Parental_Education_Level = COALESCE(Parental_Education_Level, 'Unknown'),
    Distance_from_Home = COALESCE(Distance_from_Home, 'Unknown')
WHERE Teacher_Quality IS NULL 
   OR Parental_Education_Level IS NULL 
   OR Distance_from_Home IS NULL;

-- Check Duplicate Data
SELECT COUNT(*) AS total_rows FROM studentperformancefactors;
SELECT 
    Hours_Studied, Attendance, Parental_Involvement, Access_to_Resources, 
    Extracurricular_Activities, Sleep_Hours, Previous_Scores, Motivation_Level, 
    Internet_Access, Tutoring_Sessions, Family_Income, Teacher_Quality, 
    School_Type, Peer_Influence, Physical_Activity, Learning_Disabilities, 
    Parental_Education_Level, Distance_from_Home, Gender, Exam_Score,
    COUNT(*) AS duplicate_count
FROM studentperformancefactors
GROUP BY 
    Hours_Studied, Attendance, Parental_Involvement, Access_to_Resources, 
    Extracurricular_Activities, Sleep_Hours, Previous_Scores, Motivation_Level, 
    Internet_Access, Tutoring_Sessions, Family_Income, Teacher_Quality, 
    School_Type, Peer_Influence, Physical_Activity, Learning_Disabilities, 
    Parental_Education_Level, Distance_from_Home, Gender, Exam_Score
HAVING COUNT(*) > 1;

-- Check outlier
SELECT 
    MIN(Hours_Studied) AS min_hours, MAX(Hours_Studied) AS max_hours,
    MIN(Attendance) AS min_attendance, MAX(Attendance) AS max_attendance,
    MIN(Previous_Scores) AS min_prev_score, MAX(Previous_Scores) AS max_prev_score,
    MIN(Exam_Score) AS min_exam_score, MAX(Exam_Score) AS max_exam_score
FROM studentperformancefactors;

-- Solving outlier
UPDATE studentperformancefactors
SET exam_score = 100
WHERE exam_score > 100;

-- Trim Spaces & Standardization
UPDATE studentperformancefactors
SET Parental_Involvement = TRIM(Parental_Involvement),
    Access_to_Resources = TRIM(Access_to_Resources),
    Motivation_Level = TRIM(Motivation_Level),
    Teacher_Quality = TRIM(Teacher_Quality),
    School_Type = TRIM(School_Type),
    Gender = TRIM(Gender);
    
-- Create Clean Table
CREATE OR REPLACE VIEW student_performance_cleaned AS
SELECT 
    Hours_Studied,
    Attendance,
    Parental_Involvement,
    Access_to_Resources,
    Extracurricular_Activities,
    Sleep_Hours,
    Previous_Scores,
    Motivation_Level,
    Internet_Access,
    Tutoring_Sessions,
    Family_Income,
    Teacher_Quality,
    School_Type,
    Peer_Influence,
    Physical_Activity,
    Learning_Disabilities,
    Parental_Education_Level,
    Distance_from_Home,
    Gender,
    Exam_Score
FROM studentperformancefactors;



