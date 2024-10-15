# terraform_watchtower

## **Project Overview**

- Briefly describe the project and its purpose.

## **Prerequisites**

- List the required software and versions, such as Terraform and Docker.

## **Usage**

- Provide step-by-step instructions on how to use the Terraform configuration, including initializing the working directory and applying the configuration.

## **Configuration**

- Describe the Terraform configuration, including the provider, resources, and variables used.

## **Notes**

- Add any additional notes or considerations, such as environment variables, dependencies, or troubleshooting tips.

Here's an example of what the README.md file could look like:

# **Watchtower Docker Container with Terraform**

**Project Overview** This Terraform configuration sets up a Docker container running Watchtower, a popular tool for automating Docker container updates.

## **Prerequisites**

- Docker installed on the system
- Terraform installed on the system
- The `kreuzwerker/docker` Terraform provider installed (version 3.0.2)

## **Usage**

1. Initialize the Terraform working directory by running `terraform init`
2. Apply the Terraform configuration by running `terraform apply`

## **Configuration**

The Terraform configuration consists of three main components:

- **Provider**: The Docker provider is configured to use the `kreuzwerker/docker` provider (version 3.0.2)
- **Image**: The `docker_image` resource downloads the latest Watchtower image from Docker Hub
- **Container**: The `docker_container` resource creates a new container from the Watchtower image, with the following configuration:
    - Name: `watchtower`
    - Restart policy: `always`
    - Volumes:
        - `/var/run/docker.sock` is mounted from the host system to the container
        - `/etc/localtime` is mounted from the host system to the container (read-only)
    - Environment variable: `COM_CENTURYLINKLABS_WATCHTOWER_ENABLE` is set to `true`
    - Command: `--label-enable`, `--cleanup`, and `--schedule` are passed as arguments to the container
    - Memory: The container is allocated 32MB of memory

## **Notes**

- This configuration assumes that the Docker daemon is running on the host system and that the `/var/run/docker.sock` file is accessible.
- The `COM_CENTURYLINKLABS_WATCHTOWER_ENABLE` environment variable is required for Watchtower to function correctly.
- The `--schedule` argument is set to `0 15 4 * * *`, which means Watchtower will run daily at 4:15 AM. You can adjust this schedule to suit your needs.
