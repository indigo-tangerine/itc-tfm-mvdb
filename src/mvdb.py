import boto3
import os
import logging
import json
import jsonpickle
import decimal
import sys
import datetime
from botocore.exceptions import ClientError
from boto3.dynamodb.conditions import Key, Attr
from aws_xray_sdk.core import xray_recorder, patch_all

# structured logging
import structlog
structlog.configure(processors=[structlog.processors.JSONRenderer()])
log = structlog.get_logger()

logging.basicConfig(
        format="%(message)s",
        stream=sys.stdout,
        level=logging.INFO,
        force=True,
    )

# Setup logging
logger = logging.getLogger()

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



# Helper class to convert a DynamoDB item to JSON
class DecimalEncoder(json.JSONEncoder):
    def default(self, o):
        if isinstance(o, decimal.Decimal):
            if o % 1 > 0:
                return float(o)
            else:
                return int(o)
        return super(DecimalEncoder, self).default(o)


def get_movie(year, title, event):
    structlog.contextvars.clear_contextvars()
    structlog.contextvars.bind_contextvars(
        view=event.path,
        request_id=str(event.aws_request_id),
        route=event.http_method,
    )
    # End of belongs-to-middleware.

    log = logger.bind()

    try:
        xray_recorder.begin_subsegment('dynamo_get_item')
        result = table.query(KeyConditionExpression=Key('year').eq(
            year) & Key('title').eq(title)
        )
        # logger.info(result)
        return {
            "statusCode": 200,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps(result['Items'], cls=DecimalEncoder)
        }
    finally:
        xray_recorder.end_subsegment()

def add_movie(context):

  return {
    "statusCode": 600,
    "headers": {"Content-Type": "application/json"},
    "body": {"Error": "Feature not yet implemented"}
  }

def lambda_handler(event, context):

    start_time = datetime.datetime.now()

    log.info("EVENT", event)

    year = int(event['queryStringParameters']['year'])
    title = event['queryStringParameters']['title']
    operation = event['httpMethod'].lower()

    # logger.info("Table name: {0}".format(table_name))
    # logger.info("Received event: " + jsonpickle.encode(event))
    # logger.info("## FIND MOVIE ##########################################")
    # logger.info("## Year: {0}".format(year))
    # logger.info("## Title: {0}".format(title))

    log.info(
      "STARTED", start_time,
      "Event", event ,
      "TableName", table_name,
      "Year", year,
      "Title", title
      )
    
    try:
        if operation == 'get':
            response = get_movie(year, title, event)
            
        elif operation == 'put':
            response = get_movie(event)
    
    except ClientError as e:
        logger.error(e.response['Error']['Message'])
        logger.info('## ENVIRONMENT VARIABLES\r' +
                    jsonpickle.encode(dict(**os.environ)))
        logger.info('## EVENT\r' + jsonpickle.encode(event))
        logger.info('## CONTEXT\r' + jsonpickle.encode(context))
        log.error(e.response['Error']['Message'])
    
    return response
    
## #
