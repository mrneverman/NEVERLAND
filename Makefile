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
	ansible-playbook -i inventory.cfg island-of-intelligence.yaml ;\
	ansible-playbook -i inventory.cfg nevertown_init.yaml ;\
	ansible-playbook -i inventory.cfg worktown_init.yaml ;\
	ansible-playbook -i inventory.cfg port-of-neverland_init.yaml 

RiseAndShine: Rise Shine
	# Rise And Shine NEVERLAND: Create gcloud instances defined in terraform folder; K8s cluster installation and configuration via ansible in a single make command


SinkAll:
	#Sink All: Destroy all gcloud instances
	cd terraform ;\
  terraform destroy

ListIPs:
	#List IPs of instances
	grep ansible_host ./ansible/inventory.cfg
