import pandas as pd
import pypyodbc

SERVER_NAME = 'LAPTOP-ATBQGGV6\SQLEXPRESS'
DATABASE_NAME = 'ev_locations_canada'

conn = pypyodbc.connect("""
        Driver={{SQL Server Native Client 11.0}};
        Server ={0};
        Database={1};
        Trusted_Connecton=yes;""".format(SERVER_NAME, DATABASE_NAME)
                        )

sql_query = """
SELECT * 
FROM final_table
"""
df = pd.read_sql(sql_query, conn)
