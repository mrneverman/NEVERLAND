Rise:
	# Rise NEVERLAND : Create gcloud instances defined in terraform folder
	cd terraform ;\
	terraform apply

Knock:
	# ansible ping all instance in NEVERLAND
	rm ../.ssh/known_hosts ;\
	cd ansible ;\
	ansible all -i inventory.cfg -m ping


Shine:
	#Shine NEVERLAND: K8s cluster installation and configuration via ansible
	cd ansible ;\
	ansible-playbook -i inventory.cfg island-of-intelligence_init.yaml ;\
	ansible-playbook -i inventory.cfg nevertown_init.yaml ;\
	ansible-playbook -i inventory.cfg worktown_init.yaml ;\
	ansible-playbook -i inventory.cfg port-of-neverland_init.yaml ;\
	ansible-playbook -i inventory.cfg istio_install.yaml

RiseAndShine: Rise Shine
	# Rise And Shine NEVERLAND: Create gcloud instances defined in terraform folder; K8s cluster installation and configuration via ansible in a single make command


SinkAll:
	#Sink All: Destroy all gcloud instances
	cd terraform ;\
	terraform destroy

ListIPs:
	#List IPs of instances
	grep ansible_host ./ansible/inventory.cfg

# IP address:
PortofNeverland = $(shell grep ansible_host ./ansible/inventory.cfg|grep portOfNeverland  | sed 's/.*=//g')
IslandOfIntelligence = $(shell grep ansible_host ./ansible/inventory.cfg|grep islandOfIntelligence  | sed 's/.*=//g')
Nevertown = $(shell grep ansible_host ./ansible/inventory.cfg|grep Nevertown | sed 's/.*=//g')
Worktown = $(shell grep ansible_host ./ansible/inventory.cfg|grep worktown-$(Nu) | sed 's/.*=//g')

PortofNeverland:
	ssh -o "StrictHostKeyChecking=no" -i sensitive_data/fisherman fisherman@$(PortofNeverland)

IslandOfIntelligence:
	ssh -o "StrictHostKeyChecking=no" -i sensitive_data/spyman spyman@$(IslandOfIntelligence)

Nevertown:
	ssh -o "StrictHostKeyChecking=no" -o ProxyCommand="ssh -o \"StrictHostKeyChecking=no\" -i sensitive_data/fisherman -W %h:%p fisherman@$(PortofNeverland)" -i sensitive_data/kubeman kubeman@$(Nevertown)

Worktown:
	# set Nu. for worktown number. Ex: make Worktown Nu=1
	ssh -o "StrictHostKeyChecking=no" -o ProxyCommand="ssh -o \"StrictHostKeyChecking=no\" -i sensitive_data/fisherman -W %h:%p fisherman@$(PortofNeverland)" -i sensitive_data/kubeman kubeman@$(Worktown)

