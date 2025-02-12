import boto3
from botocore.exceptions import BotoCoreError, NoCredentialsError


def upload_to_s3(file: bytes, bucket: str, key: str):
    try:
        s3_client = boto3.client("s3")
        s3_client.put_object(Bucket=bucket, Key=key, Body=file)
        print(f"File uploaded successfully: s3://{bucket}/{key}")
    except (BotoCoreError, NoCredentialsError) as e:
        print(f"Failed to upload to S3: {e}")
        raise
