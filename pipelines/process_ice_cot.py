import json
import boto3


def process_ice_cot(event):
    s3_client = boto3.client("s3")
    dynamodb = boto3.resource("dynamodb", region_name="eu-north-1")

    table_name = "aws-setup-dynamodb"

    table = dynamodb.Table(table_name)

    for record in event["Records"]:
        message_body = json.loads(record["body"])
        message = json.loads(message_body["Message"])

        bucket = message["bucket"]
        key = message["key"]

        obj = s3_client.get_object(Bucket=bucket, Key=key)
        file_content = obj["Body"].read().decode("utf-8")

        rows = file_content.split("\n")
        rows = rows[1:]
        for row in rows:
            if row.strip():
                columns = row.split(",")
                table.put_item(
                    Item={
                        "Market": columns[0],
                        "Date": columns[1],
                        "OI_All": str(columns[7]),
                    }
                )

    print("Loaded data into DynamoDB")


def handler(event, context):
    try:
        process_ice_cot(event)
    except Exception as e:
        return {"status": "Failed", "Error": str(e)}


if __name__ == "__main__":
    mock_event = {
        "Records": [
            {
                "body": json.dumps(
                    {
                        "Subject": "ICE COT File has been downloaded to aws-setup-datastore/ice_cot/COTHist2025.csv",
                        "Message": '{"status": "success", "bucket": "aws-setup-datastore", "key": "ice_cot/COTHist2025.csv"}',
                    }
                )
            }
        ]
    }

    handler(mock_event, None)
