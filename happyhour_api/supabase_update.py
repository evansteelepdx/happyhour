import os
import json
from supabase import create_client, Client

url: str = os.environ.get("SUPABASE_URL")
key: str = os.environ.get("SUPABASE_KEY")
supabase: Client = create_client(url, key)

file_path = "../happyhours.json"
with open(file_path, "r") as file:
    data = json.load(file)

    for obj in data["Restaurants"]:
        obj_id = obj["Id"]
        obj_name = obj["Name"]
        obj_address = obj["Address"]
        data = supabase.table("happy_hour").upsert({"id":obj_id, "name":obj_name, "address":obj_address}).execute()
