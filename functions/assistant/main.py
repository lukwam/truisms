"""Slack Cloud Function."""
import json
import random
from google.cloud import firestore


def assistant(request):
    """Return a Truism."""
    ref = firestore.Client().collection("truisms")
    truisms = list(ref.stream())
    truism = random.choice(truisms).id
    headers = {"Content-Type": "application/json"}
    response = {
        "fulfillmentText": truism,
        "source": "lukwam-truisms.appspot.com",
    }
    response_text = json.dumps(response, indent=2, sort_keys=True)
    print(response_text)
    return (response_text, 200, headers)


if __name__ == "__main__":
    assistant(None)
