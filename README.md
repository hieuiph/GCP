# BigQuery
## 1. Selecting the Top-1 Result in BigQuery

    Problem
    You want to return the top item from a sorted list in a BigQuery query, but your data
    set is particularly large and the query is slow.
    
    Discussion
    
    Although ROW_NUMBER() has a scalable implementation that can perform distributed
    sorts across multiple BigQuery workers, the entire sort needs to be calculated. In par‐
    ticularly large queries, using ###ARRAY_AGG allows BigQuery to drop unneeded data. This
    is a BigQuery-specific trick to speed up sorts when you know you need only the top-n
    results
