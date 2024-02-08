CREATE OR REPLACE EXTERNAL TABLE ny-taxi-412222.ny_taxi.external_green_tripdata_2022
OPTIONS (
  format = 'parquet',
  uris = ['gs://mage-zoomcamp-ny-taxi/green_tripdata_2022/green_tripdata_2022-*.parquet']
);

CREATE OR REPLACE TABLE ny-taxi-412222.ny_taxi.materialized_green_tripdata_2022 AS
SELECT * FROM ny-taxi-412222.ny_taxi.external_green_tripdata_2022;

---Question 1---
select count(*) from `ny-taxi-412222.ny_taxi.external_green_tripdata_2022`; --840402--

---Question 2---
select count(distinct PULocationID)
from `ny_taxi.external_green_tripdata_2022`; --0--
  --------
select count(distinct PULocationID)
from `ny_taxi.materialized_green_tripdata_2022`; --6.41MB--

---Question 3---
select count(*) 
from `ny-taxi-412222.ny_taxi.external_green_tripdata_2022`
where fare_amount = 0; --1622--

---Question 4---
-- Creating a partition (lpep_pickup_datetime) and cluster (PUlocationID) table
CREATE OR REPLACE TABLE ny-taxi-412222.ny_taxi.green_tripdata_2022_partitoned_clustered
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY PUlocationID AS
SELECT * FROM ny-taxi-412222.ny_taxi.external_green_tripdata_2022;
