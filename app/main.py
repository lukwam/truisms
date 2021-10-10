"""Truisms App"""
import random
from google.cloud import firestore
from flask import Flask
from flask import render_template

app = Flask(__name__)


@app.route("/")
def index():
    """Main index."""
    ref = firestore.Client().collection("truisms")
    truisms = list(ref.stream())
    truism = random.choice(truisms).id
    return render_template("index.html", truism=truism)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=True)
