"""Update Cloud Function."""
import random
from google.cloud import firestore


def truism(request):
    """Return a Truism."""
    ref = firestore.Client().collection("truisms")
    truisms = list(ref.stream())
    truism = random.choice(truisms).id
    print(truism)
    return truism


if __name__ == "__main__":
    truism(None)
