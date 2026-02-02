import os, json, datetime
import requests
import boto3

def run():
    api_url = os.environ["PHARMACY_API_URL"]
    bucket = os.environ["S3_BUCKET"]

    # 1) Fetch JSON from API
    resp = requests.get(api_url, timeout=30)
    resp.raise_for_status()
    data = resp.json()

    # 2) Build partition path (Bronze)
    today = datetime.date.today().isoformat()
    key = f"bronze/pharmacy/ingestion_date={today}/pharmacy_inventory.json"

    # 3) Upload raw JSON to S3
    s3 = boto3.client("s3")
    s3.put_object(
        Bucket=bucket,
        Key=key,
        Body=json.dumps(data).encode("utf-8"),
        ContentType="application/json"
    )

    print(f"Uploaded to s3://{bucket}/{key}")

if __name__ == "__main__":
    run()
