1. You can start by using the standard ROW_NUMBER() OVER() windowing function and
then filtering based on the first item. However, if your data set is particularly large
and performing slowly because you’re forcing a full sort of the data set, you can apply
a BigQuery-specific trick. Using ARRAY_AGG(x LIMIT 1)[OFFSET(0)] will allow Big‐
Query to drop all data that isn’t the number 1 row, increasing query performance.
======================================================================================= 
SELECT
 rental_id,
 duration,
 bike_id,
 end_date
FROM (
 SELECT
 rental_id,
 duration,
 bike_id,
 end_date,
 ROW_NUMBER() OVER (ORDER BY end_date ASC) rental_num

 FROM
 `bigquery-public-data`.london_bicycles.cycle_hire )
WHERE
 rental_num = 1
 
Query complete (18.7 sec elapsed, 743.7 MB processed)

2. Run a query using ARRAY_AGG(x LIMIT 1)[OFFSET(0)] instead. This query
should succeed more quickly.
======================================================================== 
SELECT
 rental.*
FROM (
 SELECT
 ARRAY_AGG( rentals
 ORDER BY rentals.end_date ASC LIMIT 1)[OFFSET(0)] rental
 FROM (
 SELECT
 rental_id,
 duration,
 bike_id,
 end_date
 FROM
 `bigquery-public-data`.london_bicycles.cycle_hire) rentals )
 
 Query complete (2.2 sec elapsed, 743.7 MB processed)

9 times faster !!! 

source: Google Cloud Cookbook 
