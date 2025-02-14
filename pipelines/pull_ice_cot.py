from utility.files import download_file
from utility.s3 import upload_to_s3
from utility.sns import send_sns_message


def pull_ice_cot(year: int = 2025):
    file_name = f"COTHist{str(year)}.csv"
    url = f"https://www.ice.com/publicdocs/futures/{file_name}"

    bucket = f"aws-setup-datastore"
    folder = "ice_cot/"
    key = f"{folder}{file_name}"

    sns_arn = "arn:aws:sns:eu-north-1:149536457876:ice_cot_sns_push"
    message = {"status": "success", "bucket": bucket, "key": key}

    subject = f"ICE COT File has been downloaded to {bucket}/{key}"

    file = download_file(url)
    upload_to_s3(file, bucket, key)
    send_sns_message(sns_arn, subject, message)


def handler(event, context):
    try:
        pull_ice_cot()
    except Exception as e:
        return {"status": "Failed", "Error": str(e)}


if __name__ == "__main__":
    response = handler(None, None)
