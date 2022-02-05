[portOfNeverland]
${portOfNeverlandIP}

[portOfNeverland:vars]
ansible_port = 22
ansible_user = fisherman
ansible_ssh_private_key_file = /root/NEVERLAND/sensitive_data/fisherman

[islandOfIntelligence]
${islandOfIntelligenceIP}

[islandOfIntelligence:vars]
ansible_port = 22
ansible_user = spyman
ansible_ssh_private_key_file = /root/NEVERLAND/sensitive_data/spyman

[Worktowns]
%{ for name, ip in worktownsIP}
${name} ansible_host=${ip}
%{ endfor ~}

[Worktowns:vars]
ansible_port = 22
ansible_user = kubeman
ansible_ssh_private_key_file = /root/NEVERLAND/sensitive_data/kubeman
ansible_ssh_common_args='-o StrictHostKeyChecking=no -o ProxyCommand="ssh -o \'ForwardAgent yes\' -i /root/NEVERLAND/sensitive_data/fisherman -W %h:%p fisherman@${portOfNeverlandIP} "'
