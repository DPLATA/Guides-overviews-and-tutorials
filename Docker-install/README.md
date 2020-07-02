# How to setup your Docker installation in Fedora 32 workstation 
This is a guide for installing Docker in Fedora 32 workstation OS, after following this guide you will be able to use Docker on your PC.

## Introduction
Docker is an open source containerization technology for building and containerizing your apps.

## Prerequisites
This guide assumes you have is PC running Fedora 32 workstation OS in its 64 bit version, nothing else is required.
This guide also assumes that you are trying to do a fresh install on your system where no previous Docker version was installed.

## Installing
### Step 1: ROLLBACK TO PREVIOUS CGroups IMPLEMENTATION
First, you'll have to make some changes to Fedora's firewall in order to facilitate Docker usage, run the following command to enable previous implementation of CGroups:
```
sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"
```
### Step 2: GRANT NETWORK ACCESS TO DOCKER
You'll need to grant Docker with network access, to do that you'll need to run two different commands.
The first one will add the docker interface to a trusted environment and will allow it to make remote connections:
```
sudo firewall-cmd --permanent --zone=trusted --add-interface=docker0
```
The second one will allow Docker to make local connections useful for development environments.
```
sudo firewall-cmd --permanent --zone=FedoraWorkstation --add-masquerade
```
### Step 3: INSTALL DOCKER
dnf package manager by default includes moby-engine package which is basically docker engine, we'll use it for simplicity, we'll install docker-compose too.
docker-compose is a tool useful for defining and running multi-container Docker apps.
```
sudo dnf install moby-engine docker-compose
```
### Step 4: ENABLE DOCKER DAEMON
To run docker you'll have to enable the service, do it by running the following:
```
sudo systemctl enable docker
```
You'll have to reboot your system so the service is enabled before you continue.
After that you can verify that the service is enabled by running:
```
systemctl status docker
```
And you should get an output similar to the following:
```
● docker.service - Docker Application Container Engine
     Loaded: loaded (/usr/lib/systemd/system/docker.service; enabled; vendor pr>
     Active: active (running) since Thu 2020-07-02 14:11:57 CDT; 3min 43s ago
TriggeredBy: ● docker.socket
       Docs: https://docs.docker.com
   Main PID: 973 (dockerd)
      Tasks: 20 (limit: 9126)
     Memory: 177.6M
     CGroup: /system.slice/docker.service
             ├─ 973 /usr/bin/dockerd --host=fd:// --exec-opt native.cgroupdrive>
             └─1101 containerd --config /var/run/docker/containerd/containerd.t>

Jul 02 14:11:53 localhost.localdomain dockerd[973]: time="2020-07-02T14:11:53.2>
Jul 02 14:11:53 localhost.localdomain dockerd[973]: time="2020-07-02T14:11:53.2>
Jul 02 14:11:53 localhost.localdomain dockerd[973]: time="2020-07-02T14:11:53.2>
Jul 02 14:11:53 localhost.localdomain dockerd[973]: time="2020-07-02T14:11:53.2>
Jul 02 14:11:54 localhost.localdomain dockerd[973]: time="2020-07-02T14:11:54.3>
Jul 02 14:11:55 localhost.localdomain dockerd[973]: time="2020-07-02T14:11:55.0>
Jul 02 14:11:57 localhost.localdomain dockerd[973]: time="2020-07-02T14:11:57.1>
Jul 02 14:11:57 localhost.localdomain dockerd[973]: time="2020-07-02T14:11:57.1>
Jul 02 14:11:57 localhost.localdomain systemd[1]: Started Docker Application Co>
Jul 02 14:11:57 localhost.localdomain dockerd[973]: time="2020-07-02T14:11:57.9>
```
Notice that the service is active and running.
### Step 5: EXECUTING DOCKER COMMAND WITHOUT SUDO
By default docker group is created so you now only have to add your username to the docker group
```
sudo usermod -aG docker $USER
```
### Step 6: VERIFY THE INSTALLATION
Run a docker command just to check that your install is ready to go
```
docker ps
```
## Authors
* **DGPC** 
## Acknowledgments
Big shoutout to this links with which I was able to make my own Docker install. You might want to take a look at them too!
* [Link 1](https://fedoramagazine.org/docker-and-fedora-32/)
* [Link 2](https://computingforgeeks.com/how-to-install-docker-on-fedora/)

