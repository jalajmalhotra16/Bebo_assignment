import time
import sys
from kubernetes import client, config
from datetime import datetime, timezone, timedelta

def delete_old_failed_pods(namespace):
    # Load the kube config from within the cluster
    config.load_incluster_config()

    # Initialize the Kubernetes API client
    v1 = client.CoreV1Api()

    # Get all pods in the specified namespace
    pods = v1.list_namespaced_pod(namespace)

    # Define the time threshold (pods older than 5 minutes)
    threshold_time = datetime.now(timezone.utc) - timedelta(minutes=5)

    for pod in pods.items:
        pod_creation_time = pod.metadata.creation_timestamp

        # Check if the pod is older than 5 minutes
        if pod_creation_time < threshold_time:
            containers = pod.status.container_statuses
            if containers:
                for container in containers:
                    if container.state.terminated or container.state.waiting:
                        print(f"Deleting pod {pod.metadata.name} in namespace {namespace} (Status: {pod.status.phase})")
                        v1.delete_namespaced_pod(pod.metadata.name, namespace)
                        sys.stdout.flush()
                        break
        else:
            print(f"Pod {pod.metadata.name} in namespace {namespace} is not older than 5 minutes, skipping it.")
            sys.stdout.flush()

# Define the namespaces
second_namespace = "second-namespace"  # The namespace where the cleanup is performed

# Run the cleanup process only once
delete_old_failed_pods(second_namespace)