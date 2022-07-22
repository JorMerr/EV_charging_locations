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

# Create function to get table from StatCan Web Data Services

# Define the function
def pull_statcan_table(table_name, table_ident):
    # Create variables for base_url and language identifier
    base_url = "https://www150.statcan.gc.ca/t1/wds/rest/getFullTableDownloadCSV/"
    language_ident = "/en"
    # Save the file format ending
    file_end = ".csv"
    # Generate the url string by table identifier
    url = base_url + str(table_ident) + language_ident
    # Send GET request to retrieve json data with zip archive link
    url_json = requests.get(url).json()
    # save zip archive link to variable
    archive_link = url_json["object"]
    # Save opened archive_link to access_url 
    access_url = urllib.request.urlopen(archive_link)
    # Read the zip archive and save to variable
    zf=ZipFile(BytesIO(access_url.read()))
    # Read the target table from zip archive and save to data variable
    data = zf.read(str(table_ident) + file_end)
    # Decode Bytes type data to csv format and save to pandas DataFrame
    df = pd.read_csv(io.StringIO(data.decode("utf-8")))
    # Display the dataframe of the target table to ensure proper extraction
    display(df)

    # Save DataFrame to CSV file in raw_datasets directory
    # Define file path to save data with table name from the keys in table_dict
    filepath = Path('raw_datasets/' + table_name + file_end)
    # Allow folders and subfolders to be created is needed
    filepath.parent.mkdir(parents=True, exist_ok=True)
    # Save the file
    # @NOTE: plan to write file directly to S3 bucket as csv
    df.to_csv(filepath)