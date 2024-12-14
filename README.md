# **Jenkins Pipeline for Building, Pushing, and Deploying a NestJS Application**

This project uses a Jenkins pipeline to automate the process of building a Docker image for a NestJS application, pushing it to DockerHub, and deploying it as a container.

---

## **Pipeline Overview**

The pipeline includes the following stages:

1. **Checkout Code**: Clone the source code repository from GitHub.
2. **Build Docker Image**: Build a Docker image for the application.
3. **Push Docker Image to DockerHub**: Push the Docker image to a DockerHub repository.
4. **Deploy Docker Container**: Deploy the application by running the Docker container.

---

## **Prerequisites**

Before running this Jenkins pipeline, ensure the following:

1. **Jenkins is installed** and configured.
2. **Docker** is installed on the Jenkins host and properly configured.
3. **DockerHub credentials** are stored in Jenkins:
   - Go to **Manage Jenkins** → **Manage Credentials**.
   - Add credentials with ID: `dockerhub-credentials`.
4. **GitHub Repository** contains a valid `Dockerfile`.

---

## **Pipeline Steps**

### **1. Checkout Code**

- Jenkins clones the source code from the specified GitHub repository:
  ```groovy
  git branch: 'main', url: "${GIT_REPO}"
  ```

---

### **2. Build Docker Image**

- The Docker image for the NestJS application is built using the `Dockerfile` in the repository:
  ```sh
  docker build -t ${DOCKER_IMAGE}:${IMAGE_TAG} .
  ```

- **Parameters**:
  - `DOCKER_IMAGE`: DockerHub repository name (e.g., `hamzalaabidi/nestjs-web-app`).
  - `IMAGE_TAG`: Version tag for the Docker image (e.g., `v1`).

---

### **3. Push Docker Image to DockerHub**

- Jenkins logs into DockerHub using credentials stored in Jenkins:
  ```sh
  echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
  ```

- The built Docker image is pushed to DockerHub:
  ```sh
  docker push ${DOCKER_IMAGE}:${IMAGE_TAG}
  ```

---

### **4. Deploy Docker Container**

- Any existing container with the same name is stopped and removed:
  ```sh
  docker stop nestjs-container || true
  docker rm nestjs-container || true
  ```

- The new Docker container is deployed:
  ```sh
  docker run -d -p 3000:3000 --name nestjs-container ${DOCKER_IMAGE}:${IMAGE_TAG}
  ```

- **Port Mapping**:
  - Maps port `3000` in the container to port `3000` on the host machine.

---

## **Post Actions**

- On **Success**: A success message is displayed.
- On **Failure**: A failure message is displayed with instructions to check the logs.

---

## **Execution Instructions**

1. Save the `Jenkinsfile` in the root directory of your project repository.
2. Configure a Jenkins pipeline:
   - Select **Pipeline** project type.
   - Link to your GitHub repository containing the `Jenkinsfile`.
3. Trigger the pipeline build.

---

## **Expected Outcome**

After running the pipeline:
1. The Docker image will be available in your DockerHub repository.
2. The NestJS application will be deployed and accessible on port `3000`.