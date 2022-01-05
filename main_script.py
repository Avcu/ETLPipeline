import pyspark

# create spark session
spark = pyspark.sql.SparkSession \
   .builder \
   .appName("Python Spark SQL basic example") \
   .config('spark.jars', "/Users/avcu/postgresql-42.3.1.jar") \
   .getOrCreate()

# read a table from db using spark jdbc
def extract_table_to_df(table_str):
   df = spark.read \
      .format("jdbc") \
      .option("url", "jdbc:postgresql://localhost:5432/imdb") \
      .option("dbtable", table_str) \
      .option("user", "avcu") \
      .option("driver", "org.postgresql.Driver") \
      .load()
   return df

# find average ratings and join the tables
def transform_avg_ratings(movies_df, review_df):
    ## transforming tables
    avg_rating = review_df.groupBy("film_id").mean("rating")
    df = movies_df.join(avg_rating, movies_df.id == avg_rating.film_id)
    df = df.drop("film_id")
    return df

# load transformed dataframe back to the database
def load_df_to_db(df):
    mode = "overwrite"
    url = "jdbc:postgresql://localhost:5432/imdb"
    properties = {"user": "avcu",
                  "driver": "org.postgresql.Driver"
                  }
    df.write.jdbc(url=url,
                  table = "avg_ratings",
                  mode = mode,
                  properties = properties)


if __name__ == "__main__":
   movies_df = extract_table_to_df("films")
   review_df = extract_table_to_df("reviews")

   print(movies_df.show())
   print(review_df.show())

   # pass the dataframes to the transformation function
   ratings_df = transform_avg_ratings(movies_df, review_df)

   print(ratings_df.show())

   # load the ratings dataframe 
   load_df_to_db(ratings_df)
