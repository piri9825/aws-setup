import boto3
import json


def send_sns_message(arn: str, subject: str, message: dict):
    sns_client = boto3.client("sns")

    resp = sns_client.publish(
        TopicArn=arn, Message=json.dumps(message), Subject=subject
    )

    return resp
