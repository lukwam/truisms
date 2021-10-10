"""Update Cloud Function."""
from google.cloud import firestore
from google.cloud import storage


def get_firestore_truisms():
    """Return a list of Truisms from Firestore."""
    client = firestore.Client()
    ref = client.collection("truisms")
    truisms = {}
    for doc in ref.stream():
        key = doc.id
        truism = doc.to_dict()
        truisms[key] = truism
    return truisms


def get_truisms(event):
    """Return a list of Truisms from the storage object."""
    bucket_name = event["bucket"]
    file_name = event["file"]
    blob = storage.Client().bucket(bucket_name).blob(file_name)
    truisms = {}
    for line in blob.download_as_string().decode().strip().split("\n"):
        truism = line.strip()
        if truism not in truisms:
            truisms[truism] = {
                "text": truism,
                "words": sorted(set(truism.split(" "))),
            }
    return truisms


def update(event, context):
    """Update Truisms in Firestore."""
    client = firestore.Client()

    truisms = get_truisms(event)
    print(f"Truisms: {len(truisms)}")

    firestore_truisms = get_firestore_truisms()
    print(f"Firestore Truisms: {len(firestore_truisms)}")

    # add new truisms
    for text in truisms:
        if text not in firestore_truisms:
            truism = truisms[text]
            print(f"Adding: {text}...")
            client.collection("truisms").document(text).set(truism)

    # delete truisms
    for text in firestore_truisms:
        if text not in truisms:
            print(f"Deleting: {text}...")
            client.collection("truisms").document(text).delete()

    # update truisms
    for text in truisms:
        if text not in firestore_truisms:
            continue
        truism = truisms[text]
        if  truism != firestore_truisms[text]:
            print(f"Updating: {text}...")
            client.collection("truisms").document(text).set(truism)


if __name__ == "__main__":
    event = {
        "bucket": "lukwam-truisms",
        "file": "truisms.txt",
    }
    update(event, None)
