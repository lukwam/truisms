"""Slack Redirect Cloud Function."""
import os
import requests
from google.cloud import firestore
from google.cloud import secretmanager_v1
from flask import redirect

APP_ID = "AKZTKQ56Y"
CLIENT_ID = os.environ.get("SLACK_CLIENT_ID")
CLIENT_SECRET = os.environ.get("SLACK_CLIENT_SECRET")


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

    url = "https://slack.com/api/oauth.v2.access"
    headers = {"Content-Type": "application/x-www-form-urlencoded"}
    params = {
        "client_id": CLIENT_ID,
        "client_secret": CLIENT_SECRET,
        "code": code,
    }

    # authorize the app
    response = requests.post(url, headers=headers, params=params)

    # save install to firestore
    save_install(response.json())

    return redirect(f"https://slack.com/apps/{APP_ID}")


if __name__ == "__main__":
    class Request:
        args = {"code": "fake-code"}
    slack_redirect(Request())
