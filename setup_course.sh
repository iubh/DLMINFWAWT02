#!/bin/bash

# Step 0: Environment Setup
mkdir Step0_EnvironmentSetup
cd Step0_EnvironmentSetup
echo "Instructions for setting up the development environment." > README.md
mkdir Exercises Solutions
cd ..

# Steps for Database, Backends, Frontend, Docker/Kubernetes
for step in DatabaseSetup BackendDevelopment_Nodejs BackendDevelopment_FastAPI FrontendDevelopment Docker_Kubernetes
do
  mkdir $step
  cd $step
  echo "Instructions and overview for $step." > README.md
  mkdir Exercises Solutions
  cd ..
done

echo "Course folders and files created successfully."