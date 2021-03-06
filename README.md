<div align="center" id="overwatch">
    <img src="./assets/overwatch.svg" alt="Overwatch" height="128px">
</div>

# <div align="center">Overwatch &middot; [![License Badge](https://img.shields.io/github/license/adamalston/Overwatch?color=white)](LICENSE) ![AWS Project](https://img.shields.io/badge/-Project-informational?style=flat&logo=amazon-aws&logoColor=232F3E&color=white)</div>

-   [Introduction](#introduction)
-   [Systems Architecture](#systems-architecture)
-   [Setup](#setup)
    -   [Installation & Deployment](#installation)
-   [Usage](#usage)
    -   [Browser Access](#browser-access)
    -   [Commands](#commands)
-   [Demo](#demo)
-   [Future](#future)
-   [Resources](#resources)

## Introduction

Millions of developers use AWS to bring products and services to people around the world. Code is not perfect and neither are the people writing it. Those overseeing operations need to be able to assess their deployments at all times. To help with this task, I created Overwatch.

I used [AWS](https://aws.amazon.com/), [Docker](https://www.docker.com/), [Prometheus](https://github.com/prometheus/prometheus), and [Grafana](https://github.com/grafana/grafana) to develop a monitoring solution that provides oversight for CI/CD pipelines running in the cloud so that auditors and operation’s personnel can quickly assess the health of mission-critical infrastructure.

The tight integration of Overwatch’s components allows personnel overseeing operations to assess failures quickly.

## Systems Architecture

<p align="center">
    <img src="./assets/system.png" width="600px"  alt="Systems Architecture" >
</p>

CloudWatch, Prometheus, and Node Exporter - each in their own Docker container - monitor an EC2 instance on AWS. Jenkins is running on the EC2 instance which is connected to the internet. When prompted via command, Jenkins begins running a CI/CD pipeline. This pipeline creates a Docker container where CentOS (Linux distribution) is virtualized. A GitHub repository is then cloned. The project in this repo is built and integration tests are run. The results of these integration tests are then relayed to Grafana for a user to see.

## Setup

**Cloudwatch-Exporter**

Put your AWS credentials into `cloudwatch-exporter.dockerfile`

```
ENV AWS_ACCESS_KEY_ID=value \
    AWS_SECRET_ACCESS_KEY=value
```

<details id="installation">
    <summary><b>Installation & Deployment</b></summary>

1. Clone this repository
2. Install Docker ([Mac](https://docs.docker.com/docker-for-mac/install/), [Windows](https://docs.docker.com/docker-for-windows/install/), [Linux](https://docs.docker.com/engine/install/))
3. In the project directory run `docker-compose up`
4. Navigate to Grafana ([localhost:3000](http://localhost:3000)) in a browser
5. On the left sidebar, select Configuration > Data Sources
6. Select Prometheus, set the HTTP URL to the IPv4 address of your EC2 instance with port number 9090
7. On the left sidebar, select Dashboards > Manage
8. Select New Dashboard

</details>

## Usage

### Browser Access

Prometheus: [http://localhost:9090](http://localhost:9090)

Alertmanager: [http://localhost:9093](http://localhost:9093)

Grafana: [http://localhost:3000](http://localhost:3000)

### Commands

Prometheus Reload: `curl -X POST http://localhost:9090/-/reload`

Prometheus Health Check: `curl http://localhost:9090/-/healthy`

CloudWatch Exporter Reload: `curl -X POST http://localhost:9106/-/reload`

## Demo

<div align="center">
    <img src="./assets/docker.png" width="600px" alt="Docker">
    <p>Docker</p>
    <img src="./assets/jenkins.png" width="600px" alt="Jenkins">
    <p>Jenkins</p>
    <img src="./assets/grafana.png" width="600px" alt="Grafana">
    <p>Grafana</p>
</div>

## Future

-   [x] Docker Support

    -   Advantages
        -   Keeping the processes in separate images (and thus running them in separate containers) permits each to be maintained independently. Further, each process can be secured independently.
        -   Keeping the processes in their own containers permits the running of one Prometheus container and one Grafana container for multiple containers.
        -   Along the same line, there is more flexibility in relocating containers, potentially dropping Grafana to use a Grafana hosted service, etc.
    -   Engineering Challenge
        -   Dockerizing each monitoring platform meant that the metrics needed to be pulled from a local server instead of the platforms themselves.

-   [x] Alertmanager Support

    -   Setup the Alertmanager config in [alertmanager.yml](alertmanager/alertmanager.yml) to meet your needs. Configurable options include email alerts, SMS messages, and more.

-   Automate

    -   Currently, the frontend and backend work on their own with manual entry for AWS. Automate the entire setup process connecting the frontend to the backend.

-   Dashboard
    -   Create a more robust dashboard.

</details>

## Resources

Project icon<sup>[^](#overwatch)</sup> from [flaticon.com](https://www.flaticon.com/svg/static/icons/svg/1632/1632950.svg) (edited by me)

Systems architecture diagram<sup>[^](#systems-architecture)</sup> made with [draw.io](https://draw.io/)

Systems architecture diagram icons<sup>[^](#systems-architecture)</sup> from [fontawesome.com](https://fontawesome.com/) and [simpleicons.org](https://simpleicons.org/) (both edited by me)

---

<img src="https://git.io/JUn8T" height="14px"> Thank you for your interest, this project was fun and insightful! If you have any feedback or questions, please reach out via email which can be found at [<img src="https://git.io/JTLAg" height="14px">AdamAlston.com](https://www.adamalston.com/)

[<div align="right">Back to top</div>](#readme)
