-- Data Cleaning

select * 
from layoffs_raw;

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Values or Blank Values
-- 4. Remove any Columns/Rows that are unneccesary 

CREATE TABLE layoffs_staging
LIKE layoffs_raw;

INSERT layoffs_staging
SELECT *
FROM layoffs_raw;

ALTER TABLE layoffs
RENAME TO layoffs_raw;

SELECT *
FROM layoffs_raw;

WITH duplicate_cte AS 
(
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
DELETE
FROM duplicate_cte
WHERE row_num > 1
;

SELECT *
FROM layoffs_staging
WHERE company = '';


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, 
total_laid_off, percentage_laid_off, `date`, 
stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;





