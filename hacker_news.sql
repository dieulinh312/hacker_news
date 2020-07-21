 --- Get a feel for the hacker_news table:
 --- Top 5 most popular Hacker News stories:
SELECT title, score
FROM hacker_news
  ORDER BY score DESC
  LIMIT 5;

--- Find total score of all stories:
SELECT SUM(score)
FROM hacker_news;

--- Find the individual users who have gotten combined scores of more than 200, and their combined scores
SELECT user, SUM(score)
FROM hacker_news
  GROUP BY user
  HAVING SUM(score) > 200;

--- Add top users' scores together and divide by the total score:
SELECT (309 + 304 + 282 + 517) / 6636.0;
-- NOTE: need to write 6636 as 6636.0 to get result

--- How many times has each user posted a link:
SELECT COUNT(DISTINCT timestamp), user
FROM hacker_news
  WHERE url LIKE '%watch?v=dQw4w9WgXcQ'
  GROUP BY user;

--- Which of these sites GitHub, Medium, and New York Times, feed Hacker News the most?
--- A. First, categorize each story based on their source:
SELECT CASE
    WHEN url LIKE '%github.com%' THEN 'GitHub'
    WHEN url LIKE '%medium.com%' THEN 'Medium'
    WHEN url LIKE '%nytimes.com%' THEN 'New York Times'
    ELSE 'Other'
  END AS 'Source'
FROM hacker_news;

--- B. Add a column for the number of stories from each URL
SELECT CASE
    WHEN url LIKE '%github.com%' THEN 'GitHub'
    WHEN url LIKE '%medium.com%' THEN 'Medium'
    WHEN url LIKE '%nytimes.com%' THEN 'New York Times'
    ELSE 'Other'
  END AS 'Source',
  COUNT(*)
FROM hacker_news
GROUP BY 1;

--- What is the best time of the day to post a story on Hacker News?
--- A. Take a look at the timestamp column:
SELECT timestamp
FROM hacker_news
LIMIT 10;

--- B. Test out strftime() function:
SELECT timestamp,
  strftime('%H',timestamp)
FROM hacker_news
GROUP BY 1
LIMIT 20;

--- C. Use strftime() function:
SELECT strftime('%H',timestamp), AVG(score), COUNT(DISTINCT title)
FROM hacker_news
GROUP BY 1;

--- D. Edit:
SELECT strftime('%H',timestamp) AS 'Posting hour',
       ROUND(AVG(score),2) AS 'Average Score' ,
       COUNT(DISTINCT title) AS 'Number of Stories'
FROM hacker_news
WHERE timestamp IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC;












