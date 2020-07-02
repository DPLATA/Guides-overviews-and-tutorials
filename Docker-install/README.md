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
The first one will add Docker the docker interface to a trusted environment and will allow it to make remote connections:
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
### Step 4:
### Step 5:
A step by step series of examples that tell you how to get a development env running

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc


