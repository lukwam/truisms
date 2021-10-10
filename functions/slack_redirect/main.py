"""Slack Redirect Cloud Function."""
import os
import requests
from google.cloud import firestore
from google.cloud import secretmanager_v1
from flask import redirect

APP_ID = "AKZTKQ56Y"


def get_secret(name):
    """Return a secret version payload."""
    project = os.environ.get("GCP_PROJECT")
    request = {
        "name": f"projects/{project}/secrets/{name}/versions/latest"
    }
    client = secretmanager_v1.SecretManagerServiceClient()
    response = client.access_secret_version(request=request)
    return response.payload.data.decode("utf-8")


def save_install(response):
    """Save install details to Firestore."""
    team_id = response["team"]["id"]
    team_name = response["team"]["name"]
    user_id = response["authed_user"]["id"]
    print(f"Installed by user {user_id} on team {team_name} [{team_id}].")

    key = f"{team_id}:{user_id}"
    firestore.Client().collection("installs").document(key).set(response)


def slack_redirect(request):
    """Return a Truism."""
    code = request.args.get("code")
    client_id = get_secret("slack-client-id")
    client_secret = get_secret("slack-client-secret")
    url = "https://slack.com/api/oauth.v2.access"
    headers = {"Content-Type": "application/x-www-form-urlencoded"}
    params = {
        "client_id": client_id,
        "client_secret": client_secret,
        "code": code,
    }

    # authorize the app
    response = requests.post(url, headers=headers, params=params)

    response_json = response.json()
    if response_json.get("ok"):

        # save install to firestore
        save_install(response.json())

        return redirect(f"https://slack.com/apps/{APP_ID}")

    print(f"Failed: {response_json}")
    return "Failed"


if __name__ == "__main__":
    class Request:
        args = {"code": "fake-code"}
    slack_redirect(Request())
