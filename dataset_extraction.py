# Import dependencies
import pandas as pd
from pathlib import Path
from zipfile import ZipFile
import urllib.request
import io
from io import BytesIO
from IPython.display import display
import json
import requests
from pull_statcan_table import *

# Table identifiers
# For each StatCan table to extract data, set the table name as key
# and table identifier from StatCan website as value
table_dict = {
    "EV_sales_table_raw" : 20100025,
    "LFS_table_raw" : 14100391
}

# Call the function for each key value pair in the table_dict
for key, value in table_dict.items():
    print(key)
    pull_statcan_table(key, value)
    