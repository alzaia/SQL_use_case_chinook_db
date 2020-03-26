/* 
Subject: Use case: Preparing the Yelp dataset to predict number of user fans from various metrics
Author: Aldo Zaimi
Database: Yelp database (Source: https://www.yelp.com/dataset)

*/

/*
Indicate the type of analysis you chose to do:

The user table has a lot of interesting information, including the number of useful/funny/cool votes the user has sent, 
the number of compliments of various kinds the user has reveived and the number of fans. We would like to see if we can 
predict the number of fans a user will have based on these various metrics available.
                
ii. Write 1-2 brief paragraphs on the type of data you will need for your analysis and why you chose that data:

The variable we are trying to predict is the number of fans (fans). We are going to use make a predictive model based on 
the following variables:
- Review count: we expect that users that write more reviews may have more fans.
- Days yelping: we expect that new users would have less fans than older users. We are going to start from the yelping_since 
column and create a new metric that gives the number of days the user has been yelping.
- Number of votes sent: the users can send 3 types of votes (useful, funny, cool). We expect that users who send more votes 
get more fans. We are going to create a new variable to combine these 3 types of votes.
- Average rating: it could be interesting to include the average rating of users in this analysis to see if users who give 
more positive/negative reviews have more/less fans.
- Compliments received: there are a lot of possible compliments received, but we are going to focus here on the most relevant: 
'hot stuff' compliments (compliment_hot), 'you're funny' compliment (compliment_funny), 'you're cool' compliment (compliment_cool) and 'good writer' compliment (compliment_writer). We are going to create a new variable to combine these 4 types of compliments.

We will also filter our results so we only keep users that have written at least 1 review. 
                           
                  
iii. Output of your finished dataset:

+--------------+------------------+----------------+--------------------------+---------------+-------------+
| review_count | nbr_days_yelping | nbr_votes_sent | nbr_compliments_received | average_stars | nbr_of_fans |
+--------------+------------------+----------------+--------------------------+---------------+-------------+
|          609 |           4635.0 |           8531 |                     8979 |          3.21 |         503 |
|          968 |           3285.0 |            554 |                     2759 |          4.05 |         497 |
|         1153 |           2677.0 |         368230 |                    37034 |           4.4 |         311 |
|         2000 |           2658.0 |          34856 |                     2044 |           3.6 |         253 |
|          930 |           3915.0 |          15801 |                      854 |          3.69 |         173 |
|          813 |           3826.0 |             67 |                      420 |          4.09 |         159 |
|          377 |           4068.0 |           2810 |                     2091 |          3.99 |         133 |
|         1215 |           1863.0 |          28094 |                      945 |          4.41 |         126 |
|          862 |           2913.0 |          26801 |                    11652 |           4.1 |         124 |
|          834 |           4609.0 |            947 |                     1727 |          3.68 |         120 |
|          861 |           3953.0 |           7343 |                      533 |          3.36 |         115 |
|          408 |           4168.0 |           3629 |                     1202 |          4.09 |         111 |
|          255 |           4594.0 |            341 |                      694 |          3.95 |         105 |
|         1039 |           5113.0 |           4819 |                     1157 |          3.71 |         104 |
|          694 |           3465.0 |            427 |                      508 |          3.89 |         101 |
|         1246 |           5000.0 |          18805 |                     1463 |          3.14 |         101 |
|          307 |           4766.0 |           3478 |                     2048 |           3.7 |          96 |
|          584 |           5346.0 |           8932 |                     2393 |          4.06 |          89 |
|          842 |           2727.0 |            294 |                      183 |           4.1 |          85 |
|          220 |           4092.0 |           6319 |                      579 |           4.1 |          84 |
|          408 |           4423.0 |           2319 |                     3755 |          3.67 |          81 |
|          178 |           2454.0 |           2805 |                      602 |          3.64 |          80 |
|          754 |           3854.0 |             29 |                      149 |          3.62 |          78 |
|         1339 |           4467.0 |           1947 |                      332 |          4.11 |          76 |
|          161 |           3984.0 |             29 |                      278 |          3.87 |          73 |
+--------------+------------------+----------------+--------------------------+---------------+-------------+
(Output limit exceeded, 25 of 9991 total rows shown)
         
         
iv. Provide the SQL code you used to create your final dataset:

*/

SELECT 	review_count, 
		(ROUND(JULIANDAY('now') - JULIANDAY(yelping_since))) AS nbr_days_yelping,
		(useful + funny + cool) AS nbr_votes_sent,
		(compliment_hot + compliment_cool + compliment_funny + compliment_writer) AS nbr_compliments_received,
		average_stars,
		fans AS nbr_of_fans
FROM user
WHERE (review_count > 0)
ORDER BY fans DESC;


