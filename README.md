<div align="center">
  <img src="./docs/assets/raspbernetes.png" alt="Raspbernetes">

  ## Raspbernetes

  My _Personal_ Kubernetes GitOps Repository

  _... managed with Flux, Renovate and GitHub Actions_
</div>

<div align="center">

  [![Discord](https://img.shields.io/discord/673534664354430999?style=for-the-badge&label=discord&logo=discord&logoColor=white&color=blue)](https://discord.gg/k8s-at-home)
  [![Kubernetes](https://img.shields.io/badge/Kubernetes-v1.26.3-blue?style=for-the-badge&logo=kubernetes&logoColor=white)](https://kubernetes.io/)
  [![Linux](https://img.shields.io/badge/Talos-v1.3.6-blue?style=for-the-badge&logo=linux&logoColor=white)](https://kubernetes.io/)

</div>

# 🍼 Overview

This educational project is designed to provide a hands-on learning experience for mastering Kubernetes cluster configurations and best practices. The repository showcases a declarative implementation of a Kubernetes cluster, following GitOps principles that can be utilized with a variety of tools and workflows.

The main goal of this project is to demonstrate best practices for implementing enterprise-grade security, observability, and comprehensive cluster configuration management using GitOps in a Kubernetes environment, while fostering learning and growth in the Kubernetes community.

This repository leverages a range of cutting-edge open-source tools and platforms, forming a comprehensive technology stack that demonstrates the power of the [CNCF ecosystem](https://landscape.cncf.io/).

## 📖 Table of contents

- [🍼 Overview](#-overview)
  - [📖 Table of contents](#-table-of-contents)
  - [📚 Documentation](#-documentation)
  - [📋 Requirements](#-requirements)
  - [🚀 Quick Start](#-quick-start)
  - [🔧 Hardware](#-hardware)
  - [🖥️ Technology Stack](#️-technology-stack)
  - [🤖 Automation](#-automation)
  - [🤝 Acknowledgments](#-acknowledgments)
  - [👥 Contributing](#-contributing)
    - [🚫 Code of Conduct](#-code-of-conduct)
    - [💡 Reporting Issues and Requesting Features](#-reporting-issues-and-requesting-features)
  - [📄 License](#-license)

## 📚 Documentation

- [Raspbernetes Docs](https://raspbernetes.github.io)
- [Kubernetes @Home Docs](https://k8s-at-home.com)

## 📋 Requirements

In order to effectively utilize this repository, it is important to have the following tools set up in your environment.

- [Kubernetes](https://kubernetes.io/) cluster
- [Flux](https://toolkit.fluxcd.io/get-started/) installed
- [Kustomize](https://kustomize.io/) installed
- [Taskfile](https://taskfile.dev/) installed

## 🚀 Quick Start

1. Set up the necessary environment variables:

```bash
export GITHUB_TOKEN=<your-token>
export GITHUB_USER=<your-username>
export GITHUB_REPO=<your-repo>
export CLUSTER=<target-cluster>
```

2. Verify that your cluster satisfies the prerequisites:

```bash
flux check --pre
```

3. Run the bootstrap command to install Flux and deploy into the cluster:


```bash
task cluster CLUSTER_NAME=cluster-1
```

**Note:** *Many variables in the cluster depend on your specific configuration and should be modified accordingly. Be sure to review and adjust these variables as needed to match your environment and requirements.*

## 🔧 Hardware

| Device                                                                                 | Description              | Quantity | CPU     | RAM      | Architecture | Operating System                      | Notes |
| -------------------------------------------------------------------------------------- | ------------------------ | -------- | ------- | -------- | ------------ | ------------------------------------- | ----- |
| [Protectli FW6E](https://protectli.com/product/fw6e/)                                  | Router                   | 1        | 4 Cores | 16GB RAM | AMD64        | [VyOs](https://vyos.io/)              |       |
| [Protectli VP2410 ](https://protectli.com/product/vp2410/)                             | Kubernetes Control Plane | 3        | 4 Cores | 8GB RAM  | AMD64        | [Talos Linux](https://www.talos.dev/) |       |
| [Protectli FW2B](https://protectli.com/product/fw2b/)                                  | Kubernetes Node(s)       | 3        | 2 Cores | 8GB RAM  | AMD64        | [Talos Linux](https://www.talos.dev/) |       |
| [Raspberry Pi 4 Model B](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/) | Kubernetes Node(s)       | 4        | 4 Cores | 8GB RAM  | ARM64        | [Talos Linux](https://www.talos.dev/) |       |
| [Rock Pi 4 Model C](https://rockpi.org/rockpi4#)                                       | Kubernetes Node(s)       | 6        | 4 Cores | 4GB RAM  | ARM64        | [Talos Linux](https://www.talos.dev/) |       |

## 🖥️ Technology Stack

The below showcases the collection of open-source solutions currently implemented in the cluster. Each of these components has been meticulously documented, and their deployment is managed using FluxCD, which adheres to GitOps principles.

The Cloud Native Computing Foundation (CNCF) has played a crucial role in the development and popularization of many of these tools, driving the adoption of cloud-native technologies and enabling projects like this one to thrive.

|                                                                                                                             | Name                                             | Description                                                                                                                |
| --------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------- |
| <img width="32" src="https://cncf-branding.netlify.app/img/projects/kubernetes/icon/color/kubernetes-icon-color.svg">       | [Kubernetes](https://kubernetes.io/)             | An open-source system for automating deployment, scaling, and management of containerized applications                     |
| <img width="32" src="https://cncf-branding.netlify.app/img/projects/flux/icon/color/flux-icon-color.svg">                   | [FluxCD](https://fluxcd.io/)                     | GitOps tool for deploying applications to Kubernetes                                                                       |
| <img width="32" src="https://www.talos.dev/images/logo.svg">                                                                | [Talos Linux](https://www.talos.dev/)            | Talos Linux is Linux designed for Kubernetes                                                                               |
| <img width="62" src="https://landscape.cncf.io/logos/cilium.svg">                                                           | [Cilium](https://cilium.io/)                     | GitOps tool for deploying applications to Kubernetes                                                                       |
| <img width="62" src="https://landscape.cncf.io/logos/istio.svg">                                                            | [Istio](https://istio.io/)                       | Istio extends Kubernetes to establish a programmable, application-aware network using the powerful Envoy service proxy.    |
| <img width="32" src="https://cncf-branding.netlify.app/img/projects/containerd/icon/color/containerd-icon-color.svg">       | [containerd](https://containerd.io/)             | Container runtime integrated with Talos Linux                                                                              |
| <img width="32" src="https://cncf-branding.netlify.app/img/projects/coredns/icon/color/coredns-icon-color.svg">             | [CoreDNS](https://coredns.io/)                   | A DNS server that operates via chained plugins                                                                             |
| <img width="32" src="https://metallb.universe.tf/images/logo/metallb-blue.png">                                             | [MetalLB](https://metallb.universe.tf/)          | Load-balancer implementation for bare metal Kubernetes clusters, using standard routing protocols.                         |
| <img width="32" src="https://cncf-branding.netlify.app/img/projects/prometheus/icon/color/prometheus-icon-color.svg">       | [Prometheus](https://prometheus.io)              | Monitoring system and time series database                                                                                 |
| <img width="32" src="https://cncf-branding.netlify.app/img/projects/jaeger/icon/color/jaeger-icon-color.svg">               | [Jaeger](https://jaegertracing.io)               | Open-source, end-to-end distributed tracing for monitoring and troubleshooting transactions in complex distributed systems |
| <img width="32" src="https://cncf-branding.netlify.app/img/projects/helm/icon/color/helm-icon-color.svg">                   | [Helm](https://helm.sh)                          | The Kubernetes package manager                                                                                             |
| <img width="32" src="https://cncf-branding.netlify.app/img/projects/falco/icon/color/falco-icon-color.svg">                 | [Falco](https://falco.org)                       | Container-native runtime security                                                                                          |
| <img width="32" src="https://cncf-branding.netlify.app/img/projects/flagger/icon/color/flagger-icon-color.svg">             | [Flagger](https://falco.org)                     | Progressive delivery Kubernetes operator (Canary, A/B Testing and Blue/Green deployments)                                  |
| <img width="32" src="https://cncf-branding.netlify.app/img/projects/opa/icon/color/opa-icon-color.svg">                     | [Open Policy Agent](https://openpolicyagent.org) | An open-source, general-purpose policy engine                                                                              |
| <img width="52" src="https://landscape.cncf.io/logos/kyverno.svg">                                                          | [Kyverno](https://kyverno.io/)                   | Kubernetes Native Policy Management                                                                                        |
| <img width="32" src="https://cncf-branding.netlify.app/img/projects/dex/icon/color/dex-icon-color.svg">                     | [Dex](https://github.com/dexidp/dex)             | An identity service that uses OpenID Connect to drive authentication for other apps                                        |
| <img width="32" src="https://cncf-branding.netlify.app/img/projects/crossplane/icon/color/crossplane-icon-color.svg">       | [Crossplane](https://crossplane.io/)             | Manage any infrastructure your application needs directly from Kubernetes                                                  |
| <img width="32" src="https://cncf-branding.netlify.app/img/projects/litmus/icon/color/litmus-icon-color.svg">               | [Litmus](https://litmuschaos.io)                 | Chaos engineering for your Kubernetes                                                                                      |
| <img width="32" src="https://cncf-branding.netlify.app/img/projects/openebs/icon/color/openebs-icon-color.svg">             | [OpenEBS](https://openebs.io)                    | Container-attached storage                                                                                                 |
| <img width="32" src="https://cncf-branding.netlify.app/img/projects/opentelemetry/icon/color/opentelemetry-icon-color.svg"> | [OpenTelemetry](https://opentelemetry.io)        | Making robust, portable telemetry a built in feature of cloud-native software.                                             |
| <img width="32" src="https://cncf-branding.netlify.app/img/projects/thanos/icon/color/thanos-icon-color.svg">               | [Thanos](https://thanos.io)                      | Highly available Prometheus setup with long-term storage capabilities                                                      |
| <img width="32" src="https://landscape.cncf.io/logos/cert-manager.svg">                                                     | [Cert Manager](https://cert-manager.io/)         | X.509 certificate management for Kubernetes                                                                                |
| <img width="32" src="https://grafana.com/static/img/menu/grafana2.svg">                                                     | [Grafana](https://grafana.com)                   | Analytics & monitoring solution for every database.                                                                        |
| <img width="32" src="https://github.com/grafana/loki/blob/main/docs/sources/logo.png?raw=true">                             | [Loki](https://grafana.com/oss/loki/)            | Horizontally-scalable, highly-available, multi-tenant log aggregation system                                               |
| <img width="62" src="https://velero.io/img/Velero.svg">                                                                     | [Velero](https://velero.io/)                     | Backup and restore, perform disaster recovery, and migrate Kubernetes cluster resources and persistent volumes.            |

## 🤖 Automation

This repository is automatically managed by [Renovate](https://renovatebot.com/). Renovate will keep all of the container images within this repository up to date automatically. It can also be configured to keep Helm chart dependencies up to date as well.

## 🤝 Acknowledgments

A special thank you to everyone in the Kubernetes @Home Discord community for their valuable contributions and time. Much of the inspiration for my cluster comes from fellow enthusiasts who have shared their own clusters under the k8s-at-home GitHub topic.

Also I extend heartfelt thanks to all CNCF contributors for their dedication and expertise, as their collective efforts have been vital in driving innovation and success within the cloud-native ecosystem.

For more ideas on deploying applications or discovering new possibilities, be sure to explore the [Kubernetes @Home search](https://nanne.dev/k8s-at-home-search/) search.

## 👥 Contributing

Our project welcomes contributions from any member of our community. To get started contributing, please see our [Contributor Guide](./CONTRIBUTING.md).

### 🚫 Code of Conduct

By participating in this project, you are expected to uphold the project's [**Code of Conduct**](./CODE_OF_CONDUCT.md). Please report any unacceptable behavior to the repository maintainer.

### 💡 Reporting Issues and Requesting Features

If you encounter any issues or would like to request new features, please create an issue on the repository's issue tracker. When reporting issues, include as much information as possible, such as error messages, logs, and steps to reproduce the issue.

Thank you for your interest in contributing to this project! Your contributions help make it better for everyone.

## 📄 License

This repository is [Apache 2.0 licensed](./LICENSE)
