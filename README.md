## WELCOME TO NEVERLAND
Neverland is a cluster of islands located in the middle of a tectonic area. Due to the high rate of volcanic activities and earthquakes, each island is prone to instant destruction. Thanks to advanced “as code” technology in here, each of them can be born from ashes in a short time.

There is only one motto here: Everything As Code!!

- "The Great Port of Neverland" is the main and only entry point to Neverland. It contains kubectl utility to talk to Nevertown and a firewall to protect cluster habitat from unintended visitors.
- "Nevertown" is the capital of Neverland which governs all activities in K8s cluster. It serves with control plane components including API server, key-value store(etcd), controller manager, scheduler.
- "Island of Intelligence" is the observatory of cluster islands. It is the home of Prometheus and other related tools to monitor health of cluster islands and each ongoing activities on cluster islands.
- "Worktown(s)" is  an island(s) where the hardworking residents of Neverland live.

![](https://github.com/mrneverman/NEVERLAND/blob/main/map/map.png)


## History of Neverland

- ##### AN.0 :
Neverland is created by Mr.Neverman in AN.0 with the inspiration of [Republic of Rose Island](https://en.wikipedia.org/wiki/Republic_of_Rose_Island) created by the Italian engineer Giorgio Rosa. It is created to work and get experience on latest trends in cloud native technologies in a fun way. All infrastructure components are provisioned by Terraform and live on Google Cloud platform. Thanks to IaC approches, they can be mapped to other cloud providers(AWS, Azure, DigitalOcean etc) with a minimal effort. Once the infrastructure is provisioned via Terraform, Ansible comes into play for configuration managements and deployments. Each island represents a separate virtual machine. At the initial phase of the development, all islands(VMs) were created using Ubuntu OS image which is provided by Goggle Cloud. Number of Workertowns can be dynamically provisioned and configured in case of the increase in workloads.

## Technology Roadmap of Neverland
Items in the technology roadmap of Neverland are listed  below in unordered way.
- VPC and Firewall implementation.
- Prometheus and Grafana implementation in "Island of Intelligence".
- ETCD encryption.
- Separate ETCD from Nevertown and implement it in different island for high availability and also to reduce the attack surface.
- Implementation of CD pipelines( Argo CD).
- Implementation of service mesh (Istio or Console).
- Use of Fedora CoreOS or Google Container-Optimized OS instead of Ubuntu for lightweight OS and smaller attack surface.
- Implementation of Kyverno policy engine.
- Create a very secure Worktown for top secret projects of Neverland. (Gvisor, KataContainers, AppArmor, Seccomp etc.).
- Increase the number of islands in Nevertown for high availability of K8S control plane components.
- Implementation of HashiCorp Vault.
- Automated Testing (Some ideas: https://www.youtube.com/watch?v=xhHOW0EF5u8).
