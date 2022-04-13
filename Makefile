Rise:
	# Rise NEVERLAND : Create gcloud instances defined in terraform folder
	cd terraform &&\
	terraform apply -auto-approve -var="add_master_node_to_lb=only_master-1"

Knock:
	# ansible ping all instance in NEVERLAND
	rm ../.ssh/known_hosts ;\
	cd ansible &&\
	ansible all -i inventory.cfg -m ping

Shine:
	#Shine NEVERLAND: K8s cluster installation and configuration via ansible
	cd ansible &&\
	ansible-playbook -i inventory.cfg island-of-intelligence_init.yaml &&\
	ansible-playbook -i inventory.cfg nevertown-1_init.yaml &&\
	ansible-playbook -i inventory.cfg port-of-neverland_init.yaml &&\
	ansible-playbook -i inventory.cfg town_init.yaml &&\
	ansible-playbook -i inventory.cfg cluster_settings.yaml &&\
	ansible-playbook -i inventory.cfg calico_install.yaml &&\
	ansible-playbook -i inventory.cfg istio_install.yaml &&\
	ansible-playbook -i inventory.cfg metrics-server_install.yaml &&\
	ansible-playbook -i inventory.cfg prometheus_install.yaml &&\
	ansible-playbook -i inventory.cfg sampleAcmeApp.yaml &&\
	cd ../terraform &&\
	terraform apply -auto-approve -var="add_master_node_to_lb=all_masters"

SinkAll:
	#Sink All: Destroy all gcloud instances
	cd terraform &&\
	terraform destroy -auto-approve

RiseAndShine: Rise Shine

SinkAndRise: SinkAll Rise

Reborn: SinkAll Rise Knock Shine

GoldilocksUp:
	#Run Goldilocks Dashboard: 
	test -n "$(Namespace)" || (echo "Set target namespace for Goldilocks. Ex: make GoldilocksUp Namespace=sampleapp" ; exit 1) &&\
	cd terraform &&\
	terraform apply -auto-approve -var="firewall-allow-goldilocks-dashboard=true" -var="add_master_node_to_lb=all_masters" &&\
	cd ../ansible &&\
	ansible-playbook -i inventory.cfg goldilocks_install.yaml --extra-vars "Namespace=$(Namespace)"

GoldilocksDown:
	#Down Goldilocks Dashboard: Set namespace for Goldilocks. Ex: Namespace=sampleapp
	test -n "$(Namespace)" || (echo "Set target namespace for Goldilocks. Ex: make GoldilocksDown Namespace=sampleapp" ; exit 1) &&\
	cd terraform &&\
	terraform apply -auto-approve -var="firewall-allow-goldilocks-dashboard=false" -var="add_master_node_to_lb=all_masters"  &&\
	cd ../ansible &&\
	ansible-playbook -i inventory.cfg goldilocks_uninstall.yaml --extra-vars "Namespace=$(Namespace)"

LocustDashboardIP = $(shell curl -s https://ipecho.net/plain)
LocustUp:
	#Run Locust Dashboard
	cd locust &&\
	sed -i 's/.*neverland.com/$(IslandOfIntelligence) neverland.com/' /etc/hosts &&\
	echo "Locust dashboard IP=       $(LocustDashboardIP):8089" &&\
	rm locust.out.log locust.std.err 2> /dev/null || true ;\
	locust --host=https://neverland.com --web-host=0.0.0.0 --web-port=8089 --loglevel=DEBUG --logfile=locust.out.log 2> locust.std.err

ListIPs:
	#List IPs of instances
	cd terraform &&\
	terraform show|grep Outputs: -A100

# IP address:
PortofNeverland = $(shell grep ansible_host ./ansible/inventory.cfg|grep portOfNeverland  | sed 's/.*=//g')
IslandOfIntelligence = $(shell grep ansible_host ./ansible/inventory.cfg|grep islandOfIntelligence  | sed 's/.*=//g')
Nevertown = $(shell grep ansible_host ./ansible/inventory.cfg|grep nevertown-$(Nu) | sed 's/.*=//g')
Worktown = $(shell grep ansible_host ./ansible/inventory.cfg|grep worktown-$(Nu) | sed 's/.*=//g')
Infratown = $(shell grep ansible_host ./ansible/inventory.cfg|grep infratown-$(Nu) | sed 's/.*=//g')

PortofNeverland:
	ssh -o "StrictHostKeyChecking=no" -i sensitive_data/fisherman fisherman@$(PortofNeverland)

IslandOfIntelligence:
	ssh -o "StrictHostKeyChecking=no" -i sensitive_data/spyman spyman@$(IslandOfIntelligence)

Nevertown:
	test -n "$(Nu)" || (echo "set Nu. for nevertown number. Ex: make Nevertown Nu=1" ; exit 1) &&\
	ssh -o "StrictHostKeyChecking=no" -o ProxyCommand="ssh -o \"StrictHostKeyChecking=no\" -i sensitive_data/fisherman -W %h:%p fisherman@$(PortofNeverland)" -i sensitive_data/kubeman kubeman@$(Nevertown)

Worktown:
	test -n "$(Nu)" || (echo "set Nu. for worktown number. Ex: make Worktown Nu=1" ; exit 1) &&\
	ssh -o "StrictHostKeyChecking=no" -o ProxyCommand="ssh -o \"StrictHostKeyChecking=no\" -i sensitive_data/fisherman -W %h:%p fisherman@$(PortofNeverland)" -i sensitive_data/kubeman kubeman@$(Worktown)

Infratown:
	test -n "$(Nu)" || (echo "set Nu. for infratown number. Ex: make Infratown Nu=1" ; exit 1) &&\
	ssh -o "StrictHostKeyChecking=no" -o ProxyCommand="ssh -o \"StrictHostKeyChecking=no\" -i sensitive_data/fisherman -W %h:%p fisherman@$(PortofNeverland)" -i sensitive_data/kubeman kubeman@$(Infratown)

