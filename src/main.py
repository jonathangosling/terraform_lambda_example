import json
from req import get_requests_version

def lambda_handler(event, context):
    return {'statusCode': 200,
                    'body': json.dumps(get_requests_version())
            }
