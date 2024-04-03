# feedbackAppChart

Functionality:
The application surveys users for feedback through a dynamic HTML page connected to a database. It collects feedback on 10 questions and displays results on a dashboard.

Deployment Method:
Utilizing Kubernetes with KinD (Kubernetes in Docker) and advanced Bash scripting techniques for logging, error handling, and deployment options for MongoDB as either a single instance or a cluster.

# Logging and Error Handling:

Implementing logging for all major operations, redirecting stdout and stderr to log files with variable filenames.
Employ error handling to check command success, alerting users and gracefully terminating the script on failure.

# MongoDB Deployment:

Enhance the script to prompt users for MongoDB deployment preference: single instance or cluster.
Dynamically generate and apply Kubernetes manifests based on user input.
For cluster setup, ensure appropriate workload method and configuration for inter-pod communication and data persistence.

# Script Organization:

Break down deployment process into well-defined functions within Bash scripts.
Separate functions for prerequisite checks, MongoDB deployment, Flask application deployment, and resource cleanup.
Organize common functionalities into reusable scripts or functions for better maintainability and modularity.

# Custom Settings:

Prompt users for custom settings such as Python version, Flask app configurations, and MongoDB settings.
Apply these configurations dynamically during deployment.

# Main Deployment Script:

Set up KinD cluster with logging and error checks.
Configure environment based on user input.
Deploy MongoDB (single instance or cluster) and ensure correct connection with Flask application.
Implement robust logging and error handling throughout the deployment process.

In summary, the deployment process involves orchestrating the setup of a Kubernetes environment with KinD, deploying MongoDB and Flask application with user-specified configurations, while ensuring logging and error handling for a smooth and reliable deployment experience.
