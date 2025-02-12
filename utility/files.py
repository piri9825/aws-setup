import requests


def download_file(url: str) -> bytes:
    try:
        response = requests.get(url)
        response.raise_for_status()
        return response.content

    except requests.RequestException as e:
        print(f"Error downloading file: {e}")
        raise
