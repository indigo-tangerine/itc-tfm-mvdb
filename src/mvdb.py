import boto3
import os
import logging
import json
import jsonpickle
import decimal
from datetime import datetime
from botocore.exceptions import ClientError
from boto3.dynamodb.conditions import Key, Attr
from aws_xray_sdk.core import xray_recorder, patch_all

# Set some variables
table_name = os.environ['TABLE_NAME']
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table(table_name)
dynamo_client = boto3.client('dynamodb')
lambda_client = boto3.client('lambda')

# Patch all supported modules to enable automatic instrumentation
patch_all()

# Configure X-ray
xray_recorder.configure(context_missing='LOG_ERROR', service='movie_db')

# Setup logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

# Helper class to convert a DynamoDB item to JSON


class DecimalEncoder(json.JSONEncoder):
    def default(self, o):
        if isinstance(o, decimal.Decimal):
            if o % 1 > 0:
                return float(o)
            else:
                return int(o)
        return super(DecimalEncoder, self).default(o)


def get_movie(year, title):
    try:
        xray_recorder.begin_subsegment('dynamo_get_item')
        result = table.query(KeyConditionExpression=Key('year').eq(
            year) & Key('title').eq(title)
        )
        logger.info(result)
        return {
            "statusCode": 200,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps(result['Items'], cls=DecimalEncoder)
        }
    finally:
        xray_recorder.end_subsegment()


def lambda_handler(event, context):

    year = int(event['queryStringParameters']['year'])
    title = event['queryStringParameters']['title']
    operation = event['httpMethod'].lower()

    logger.info("Table name: {0}".format(table_name))
    logger.info("Received event: " + json.dumps(event, indent=2))
    logger.info("##-FIND-MOVIE-##########################################")
    logger.info("Year to find: {0}".format(year))
    logger.info("Title to find: {0}".format(title))

    try:
        if operation == 'get':
            return get_movie(year, title)
        elif operation == 'put':
            return print("Not yet implemented")

    except ClientError as e:
        logger.error(e.response['Error']['Message'])
        logger.info('## ENVIRONMENT VARIABLES\r' +
                    jsonpickle.encode(dict(**os.environ)))
        logger.info('## EVENT\r' + jsonpickle.encode(event))
        logger.info('## CONTEXT\r' + jsonpickle.encode(context))
