# Step 4: Docker and Kubernetes

In this step, we will containerize our microservices and frontend using Docker and then deploy them using Kubernetes from Docker Desktop. This step provides an insight into using Docker for containerization and Kubernetes for orchestration.

## Overview

You will learn how to:
1. Create Docker images for the FastAPI and Node.js microservices.
2. Create a Docker image for the Next.js frontend.
3. Set up Kubernetes to manage these containers using Docker Desktop.

## Prerequisites

- Completion of Steps 0, 1, 2, and 3
- Basic understanding of Docker and Kubernetes
- Docker Desktop with Kubernetes enabled

## Step 4.1: Dockerizing the Microservices

### 1. Dockerize the FastAPI Microservice

#### Create a Dockerfile

Create a `Dockerfile` in the `reservations` directory:

```Dockerfile
# reservations/Dockerfile

# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Run uvicorn server when the container launches
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

#### Build the Docker Image

Navigate to the `reservations` directory and build the Docker image:

```sh
cd reservations
docker build -t reservations-service .
```

### 2. Dockerize the Node.js Microservice

#### Create a Dockerfile

Create a `Dockerfile` in the `auth` directory:

```Dockerfile
# auth/Dockerfile

# Use an official Node.js runtime as a parent image
FROM node:18

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install any needed packages
RUN npm install

# Copy the current directory contents into the container at /app
COPY . .

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Run server.js when the container launches
CMD ["node", "server.js"]
```

#### Build the Docker Image

Navigate to the `auth` directory and build the Docker image:

```sh
cd auth
docker build -t auth-service .
```

### 3. Dockerize the Next.js Frontend

#### Create a Dockerfile

Create a `Dockerfile` in the `my-app` directory:

```Dockerfile
# my-app/Dockerfile

# Use an official Node.js runtime as a parent image
FROM node:18

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install any needed packages
RUN npm install

# Copy the current directory contents into the container at /app
COPY . .

# Build the Next.js app
RUN npm run build

# Expose port 3000 to the world outside this container
EXPOSE 3000

# Start the Next.js app
CMD ["npm", "run", "start"]
```

#### Build the Docker Image

Navigate to the `my-app` directory and build the Docker image:

```sh
cd my-app
docker build -t frontend-service .
```

## Step 4.2: Using Kubernetes with Docker Desktop

### 1. Set Up Kubernetes Configuration

#### Create Kubernetes Deployment Files

Create a `k8s` directory in the root of your project and add the following deployment files:

##### FastAPI Microservice Deployment

```yaml
# k8s/reservations-deployment.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: reservations-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: reservations
  template:
    metadata:
      labels:
        app: reservations
    spec:
      containers:
      - name: reservations
        image: reservations-service
        ports:
        - containerPort: 8000
---
apiVersion: v1
kind: Service
metadata:
  name: reservations-service
spec:
  selector:
    app: reservations
  ports:
    - protocol: TCP
      port: 8000
      targetPort: 8000
```

##### Node.js Microservice Deployment

```yaml
# k8s/auth-deployment.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: auth-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: auth
  template:
    metadata:
      labels:
        app: auth
    spec:
      containers:
      - name: auth
        image: auth-service
        ports:
        - containerPort: 5000
---
apiVersion: v1
kind: Service
metadata:
  name: auth-service
spec:
  selector:
    app: auth
  ports:
    - protocol: TCP
      port: 5000
      targetPort: 5000
```

##### Next.js Frontend Deployment

```yaml
# k8s/frontend-deployment.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - name: frontend
        image: frontend-service
        ports:
        - containerPort: 3000
---
apiVersion: v1
kind: Service
metadata:
  name: frontend-service
spec:
  selector:
    app: frontend
  ports:
    - protocol: TCP
      port: 3000
      targetPort: 3000
```

### 2. Deploy to Kubernetes

#### Enable Kubernetes in Docker Desktop

1. Open Docker Desktop.
2. Go to Settings.
3. Navigate to the Kubernetes tab.
4. Check "Enable Kubernetes".
5. Click "Apply & Restart".

#### Apply Kubernetes Configurations

Open your terminal, navigate to the `k8s` directory, and apply the configurations:

```sh
kubectl apply -f reservations-deployment.yaml
kubectl apply -f auth-deployment.yaml
kubectl apply -f frontend-deployment.yaml
```

### 3. Access the Applications

#### Get the URLs

You can access the services using the Kubernetes service command:

```sh
kubectl get services
```

This command will list the services and their corresponding external IPs or ports. You can use this information to access your services in the browser.

For example, if the `frontend-service` is exposed on port 3000, you can access it at:

```
http://localhost:3000
```

## Summary

You have now containerized your FastAPI and Node.js microservices as well as your Next.js frontend using Docker. You have also set up Kubernetes using Docker Desktop to manage these containers. This setup allows you to run and orchestrate your microservices and frontend in a scalable and efficient manner.
