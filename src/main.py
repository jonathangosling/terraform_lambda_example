import json
from exp_int import get_exp_integral

def lambda_handler(event, context):
    if event["value"] != None:
        try:
            x = float(event["value"])
            return {'statusCode': 200,
                    'body': json.dumps(get_exp_integral(x))
            }

        except:
            return {'statusCode': 500,
                    'body': json.dumps("Incompatible value passed")
            }
    else:
        return {'statusCode': 200,
                'body': json.dumps('''Supply a value as a query parameter
                                      to get the exponential integral e.g. 
                                      "value=1"''')
        }
