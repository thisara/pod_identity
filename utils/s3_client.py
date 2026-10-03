import os
import boto3
from typing import List, Dict
from botocore.exceptions import ClientError

class S3Client:

    def __init__(self):

        self.bucket_name = os.environ["AWS_S3_BUCKET"]

        #config-check-start==============================

        session = boto3.Session()

        credentials = session.get_credentials()

        print("AWS bucket:", self.bucket_name)
        print("AWS region:", session.region_name)

        if credentials:
            print("Credential method:", credentials.method)
        else:
            print("No AWS credentials found")

        sts = session.client("sts")

        identity = sts.get_caller_identity()

        print("AWS Account:", identity["Account"])
        print("AWS ARN:", identity["Arn"])

        #config-check-end==============================

        self.s3 = boto3.client(
            "s3",
            region_name=os.getenv(
                "AWS_REGION",
                "ap-southeast-2"
            )
        )

    def put_object(self, key: str, content: bytes, content_type: str) -> None:
        
        try:
            self.s3.put_object(
                Bucket=self.bucket_name,
                Key=key,
                Body=content,
                ContentType=content_type)

        except ClientError as error:
            raise RuntimeError("Unable to upload file to S3: {}".format(key)) from error

    def list_objects(self) -> List[Dict]:

        try:

            paginator = self.s3.get_paginator("list_objects_v2")

            objects = []

            for page in paginator.paginate(Bucket=self.bucket_name):

                for item in page.get("Contents", []):

                    objects.append({
                        "key": item["Key"],
                        "size": item["Size"]
                    })

            return objects

        except ClientError as error:
            raise RuntimeError("Unable to list S3 files") from error

def get_s3_client() -> S3Client:
    return S3Client()