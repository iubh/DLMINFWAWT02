# Step 0: Environment Setup

Welcome to Step 0 of the Web Architecture Practical Course! In this step, you will set up the development environment necessary to build and run the web-based reservation system.

## Overview

This step involves installing essential tools and setting up your development environment. By the end of this step, you should have Visual Studio Code, Python, Node.js, Docker, and Kubernetes installed, and a Python virtual environment set up.

## Tools Installation

### 1. Install Visual Studio Code (VSCode)

Visual Studio Code is a powerful, free code editor that works with many programming languages.

- **Download:** [VSCode Download](https://code.visualstudio.com/)
- **Installation:**
  - Follow the instructions on the download page to install VSCode for your operating system.

### 2. Install Python

Python is a versatile programming language that you'll use for backend development.

- **Download:** [Python Download](https://www.python.org/downloads/)
- **Installation:**
  - Choose the latest version of Python and follow the installation instructions.
  - Make sure to check the box that says "Add Python to PATH" during installation.

### 3. Install Node.js

Node.js is a JavaScript runtime used for backend development.

- **Download:** [Node.js Download](https://nodejs.org/)
- **Installation:**
  - Download and install the LTS (Long Term Support) version for your operating system.

### 4. Install Docker

Docker is a platform for developing, shipping, and running applications in containers.

- **Download:** [Docker Download](https://www.docker.com/products/docker-desktop)
- **Installation:**
  - Follow the instructions to install Docker Desktop for your operating system.
  - After installation, start Docker Desktop and make sure it is running.

### 5. Install Kubernetes

Kubernetes is an orchestration tool for managing containerized applications.

- **Download and Setup:**
  - Kubernetes is included with Docker Desktop. Make sure Kubernetes is enabled in Docker Desktop settings.

## Python Virtual Environment Setup

Creating a virtual environment helps to manage dependencies and avoid conflicts between projects.

### 1. Create a Virtual Environment

Open a terminal or command prompt and run the following commands:

```sh
# Navigate to your project directory
cd /path/to/your/project

# Create a virtual environment
python -m venv venv
```

### 2. Activate the Virtual Environment

- **Windows:**
  ```sh
  venv\Scripts\activate
  ```
- **macOS/Linux:**
  ```sh
  source venv/bin/activate
  ```

### 3. Verify the Virtual Environment

After activation, you should see `(venv)` at the beginning of your terminal prompt. You can also check the Python version to ensure it's using the virtual environment's Python:

```sh
python --version
```

## Summary

You have now set up your development environment by installing VSCode, Python, Node.js, Docker, and Kubernetes. Additionally, you've created and activated a Python virtual environment. You're ready to proceed to the next step of the course.

If you encounter any issues during setup, refer to the official documentation of each tool for troubleshooting, or seek help from your instructor or classmates.

---

Proceed to [Step 1: Database Setup](../1.Database%20Setup/README.md) to continue with the course.

