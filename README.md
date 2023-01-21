# Project1

a general idea of how you could set up a Kubernetes cluster with MongoDB app containers, including production best practices such as resource limitations, security and high availability.

Steps: 

Create a VPC and configure security groups to restrict traffic to the cluster.
Use a tool like terraform to create the Kubernetes cluster
Use Kubernetes manifests (YAML files) to create the necessary Kubernetes objects such as Deployment, Service, ConfigMap, and Secrets.
Use a Kubernetes PodSecurityPolicy to limit the Linux capabilities of the container.
Use Kubernetes Network Policies to restrict access to the MongoDB pods
Use Kubernetes Persistent Volume Claims to ensure data is stored persistently
Use Kubernetes probes such as readiness and liveness to check the health of the MongoDB pods
Use Kubernetes Jobs or third-party tools to automate regular backups of your data
Monitor your MongoDB cluster using Kubernetes metrics and logs.
Use Kubernetes Audit Logs to track changes made to the MongoDB pods, services, and configurations.
