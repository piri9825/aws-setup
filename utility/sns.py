import boto3
import json


def send_sns_message(arn: str, subject: str, message: dict) -> None:
    sns_client = boto3.client("sns", region_name="eu-north-1")

    sns_client.publish(TopicArn=arn, Message=json.dumps(message), Subject=subject)

    print(f"Message Sent: {json.dumps(message)}")
