from utility.files import download_file
from utility.s3 import upload_to_s3

year = 2025
file_name = f"COTHist{str(year)}.csv"
url = f"https://www.ice.com/publicdocs/futures/{file_name}"

bucket = f"aws-setup-datastore"
folder = "ice_cot/"
key = f"{folder}{file_name}"

file = download_file(url)
upload_to_s3(file, bucket, key)
