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
installation is beyond the scope of this tutorial, so you should have already running on your PC Docker and Minikube. Also we'll be developing a simple express web server but it's explanation is also not covered
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
Now add the following to have your server fully functional.
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
For dockerizing the server first create a .dockerignore file that's useful for optimizing the docker image.
```
touch .dockerignore
```
In it for now you'll just want to add the node modules directory but I encourage you to learn more about it, why it's useful and how to create a perfect .dockerignore file.
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

## Built With

* [link](http://www.dropwizard.io/1.0.2/docs/) - Link 1 to dropwizard now but about to be changed - the web framework used

## Author

* **DGPC** 

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc


