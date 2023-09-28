import docker
import json

# Initialize the Docker client
client = docker.from_env()

# Define the names of the containers you want to collect logs from
container_names = ["server", "sender"]

# Initialize an empty dictionary to store the logs
logs_data = {}

# Collect logs from each container
for container_name in container_names:
    try:
        container = client.containers.get(container_name)
        logs = container.logs().decode("utf-8").splitlines()
        logs_data[container_name] = logs
    except docker.errors.NotFound:
        print(f"Container '{container_name}' not found.")

# Save the logs data to a JSON file
with open("container_logs.json", "w") as json_file:
    json.dump(logs_data, json_file, indent=4)

print("Logs collected and saved to 'container_logs.json'.")
