## Usage

### 1. install ansible

`sudo apt install ansible`

### 2. apply playbook

run

`ansible-pull -U https://github.com/bookvoed/team.git --ask-become-pass dev.yml [--check] [--diff]`

**or**

clone repository and run 

`ansible-playbook dev.yml --ask-become-pass`

### 3. repeat