# Kubernetes (Minikube) tutorial for complete beginners 

This tutorial provides a step by step by guide for developing a simple web server (using Node js and express), containerizing it (using Docker) and deploying it to a kubernetes cluster (using Minukube).

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. I recommend you to follow along writing your own files but my source code will
be uploaded in this repo so that you can check it out in case of any problem.

## Audience

This tutorial is prepared for those who want to understand what containerizing and deployment of applications using container orchestration is. This tutorial will help you understand the basic principles of
dockerizing an app plus kubernetes deployment basics.

## Prerequisites

This tutorial was built on a PC running Fedora 32 OS so Linux or MacOS environments will be better suited to follow along. You need no previous knowledge about neither Docker nor Kubernetes but their
installation is beyond the scope of this tutorial, so you should have already running on your PC Docker, Minikube and kubectl. Also we'll be developing a simple express web server but it's explanation is also not covered
in this guide so you should have a basic understanding of web development, plus have installed Node js and npm. I'll try my best to explain concepts in depth ;).

## Introduction

### Kubernetes
Kubernetes or K8's is an open-source system originally developed by google for automating deployment, scaling and management of containerized applications.
### Docker
On the other hand Docker is an open platform for developing, shipping and running applications. Docker enables you to separate your apps from infrastructure so you can deliver software quicker.
### Docker + kubernetes
Kubernetes as a container orchestrator let you manage your Dockerized applications in a production setting.
### Minikube
Minikube is a way of running kubernetes clusters in your local environment.

## Now the fun part

### Step 1: DEVELOP THE WEB SERVER
You'll want to have your server on a separate directory, so create one
```
mkdir server && cd server
```
Init your project
```
npm init
```
You'll have to fill out some of your project's info like author, version, git repo and description.
Once it's done, create your server file
```
touch index.js
```
Now add the following to have your server fully functional
```
let express = require('express');
let app = express();
let port = 8080;

app.get('/', (req, res) => {
    res.send('Hello Docker + Minikube tutorial! ;)')
});

app.listen(port, () => {console.log('app listening on port:', port)})
```
Start your server
```
node index.js
```
Now you should be able to go into **http://localhost:8080** in your browser and see Hello Docker + Minikube tutorial! ;)

### Step 2: DOCKERIZING THE SERVER
Now that the simple web server is up and running you'll want to dockerize it in order to deploy it using Minikube.  
For dockerizing the server first create a .dockerignore file that's useful for optimizing the Docker image
```
touch .dockerignore
```
In it for now you'll just want to add the node modules directory but I encourage you to learn more about it, why it's useful and how to create a perfect .dockerignore file
```
node_modules
```
Now the dockerfile!  
A Dockerfile is the file that specifies how you want to build your image. Just copy for now I'll explain after. 

```
FROM node:latest

WORKDIR usr/src/app

COPY package*.json ./

RUN npm install

COPY . ./

EXPOSE 8080

CMD ["node", "index.js"]
```
So what this is doing is first choosing the latest nodejs image available in the docker hub for using it as the building block in which we are going to add our app. It seems like a good idea to use a node image since our app is built using node and express but there are a lot more images available in the docker hub. After that a WORKDIR is established and everything we copy is going to be copied into that folder. Now we'll build the app inside the container for that we need the dependencies in our container so we'll COPY our package.json and package-lock.json and run the installation of dependencies declared in those file for that you'll RUN npm install inside the container.
Next COPY the whole app and EXPOSE inside the container the port in which the app is meant to run in this case we declared that port to be 8080.
All that's left to do now is start the application which the last line of the file is meant to do.

Now to build the image you should be positioned inside your server folder and run the following command
```
docker build -t myexpressserver .
```
This will build your Docker image based on the Dockerfile recently created. The image name will be myexpressserver or any other you'd like to put instead.   
Now let's run it just to verify that everything is working fine
```
docker run --name myexpresscontainer -p 8000:8080 -d myexpressserver
```
So what does this command do? well, it starts a docker process; it starts the previously built image (myexpressserver) as a docker container named myexpresscontainer (or you could name it differently), maps your computer's port 8000 to the container's port 8080 (which is the one that exposes the application), plus the process is executed in detach mode which basically means that the process is ran in the background.
Now you should be able to go into **http://localhost:8000** in your browser and see Hello Docker + Minikube tutorial! ;)  
Notice that the port changed that is because of the mapping we did on the running the image stage. Also notice that the container is running the app, not your computer. Isn't that cool?

### Step 3: MINIKUBE
Now that the web server is containerized as a Docker image, let's deploy it to a kubernetes cluster, we'll do it using minikube which lets you run a local single node kubernetes cluster, and kubectl which is a command line tool for managing kubernetes clusters, so let's begin.  
First thing is to start our kubernetes cluster
```
minikube start
```
Minikube runs on a VM so lets ssh into it
```
minikube ssh
```
We'll need to copy our image (more on this later) into our kubernetes cluster so for that we'll set up a password for our docker (default) user in our minikube VM
```
sudo passwd docker
```
Fill in your new password and retype it to confirm, don't forget to write it down so you don't lose it, you'll need it later.
Now that your password is set up type exit to return to your PC terminal environment.  
So now the why on copying the image from your local PC to your minikube environment. Your PC has its own Docker registry and since Minikube runs on a VM runs its own (different from your PC's) Docker registry, so Docker images on your PC will not necessarily be on your Minikube cluster, unless you manually copy the dockerfile into your minikube environment and build the image, so let's do it.
```
minikube ip
```
This will output your cluster's ip address, write it down. Next step is to copy the server project into your cluster.
```
scp -r server docker@yourminikubeIPaddress:~/
```
This will prompt a text input for you to type in the previously created password. Verify that directory copied successfully.
```
minikube ssh
```
```
ls
```
You should see as output the directory name.  
Now you should build the image inside the cluster
```
docker build -t myexpressserver .
```
So now all that's left to do is create a kubernetes deployment, and expose it through a service.  
Kubernetes is managed through yaml files, so let's create a sample yaml file for configuring a deployment which we'll modify afterwards, but you should exit your minikube terminal first
```
kubectl create deployment expressdeployment --image=myexpressserver --dry-run=client -o yaml > expressdeployment.yaml
```
This will generate expressdeployment.yaml file inside your root project folder, or you could create a separate folder to keep your kubernetes configuration files just like I did.  
Now let's edit that file, at first you should have something like this
```
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: expressdeployment
  name: expressdeployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: expressdeployment
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: expressdeployment
    spec:
      containers:
      - image: myexpressserver
        name: myexpressserver
        resources: {}
status: {}
```
Now in the spec: containers: section right at the end of the file after the name you should add the following (remember that in yaml file indentation is important so you should work at the same level)
```
imagePullPolicy: IfNotPresent
ports:
- containerPort: 8080
```
Now that the yaml file is modified run the following
```
kubectl apply -f expressdeployment.yaml
```
This will create a pod with your web server and a deployment containing a single replica of that pod.  
Now you'll just have to expose the deployment through a service
```
kubectl expose deployment expressdeployment --type=LoadBalancer --target-port=8080 --port=80
```
Minikube won't assign an extrenal IP address for the service but in a cloud environment the kubernetes engine will assign one and port 80 (default http) will map to your app.  
And that's it, you are all done for deploying a docker image in a kubernetes cluster using Minikube.
If you have any doubts you can try to contact me. I'm by no means the greatest kubernetes mind but sure I can try to help out! ;)

## Author

* **DGPC** 

## Acknowledgments

 Hat tip to the following resources with which I built this tutorial
* [kubernetes reference docs](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#expose) 
* [kubernetes deployment tutorial](https://devopscube.com/kubernetes-deployment-tutorial/)
* [Kubernetes cluster setup](https://jee-appy.blogspot.com/2018/05/setup-kubernetes-cluster-locally.html)

