## Usage

### 1. install ansible
```
sudo add-apt-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible
```

### 2. apply playbook

run

`ansible-pull -U https://github.com/bookvoed/team.git --ask-become-pass [--check]`

**or**

clone repository and run 

`ansible-playbook local.yml --ask-become-pass [--check] [--diff]`

### 3. repeat