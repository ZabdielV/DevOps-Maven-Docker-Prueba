### Run proyect (personal notes)

Jenkinsfile is the root where all files are executed (for reference location).

1. In host machine install docker, docker compose

2. Run git clone command in host machine (vagrant/aws), run it from /home/ directory

```sh
   cd /home/ &&
   git clone https://github.com/ZabdielV/Jenkins-Pipeline-Docker-Project.git
```

3. Once cloned, create jenkins_home at the same level that jenkins-data. Change a file ownership

```sh
   cd /home/Jenkins-Pipeline-Docker-Project/jenkins/jenkins-data/ &&
   mkdir jenkins_home && sudo chown 1000:1000 /var/run/docker.sock

```

4. Run docker compose up

```sh
   docker compose up
```

The pipeline should be executed every time the code changes in /deploy branch.

- Create remote machine in aws (with docker and docker compose) //deploy machine
- Install ssh in both machines with all access (create new linux user in remote machine called **"prod-user"** and copy public key of local machine to remote machine).

  - In remote machine switch to prod-user, create folder **/home/prod-user/.ssh**, change execution with chmod 700 .ssh/
  - In folder .ssh/authorized_keys paste public key from local machine.
  - execute chmod 400 .ssh/authorized_keys

- Local machine will try to log in remote machine using private key (host).

  - Copy private key of host machine to `/opt/prod` with `prod` name
    - Change private key ownership to 1000:1000
  - Change private key execution with :`chmod 400 prod`

- In remote machine execute the following commands (/home/):
  - prod-user@ip-172-31-14-184:~$ mkdir maven
  - prod-user@ip-172-31-14-184:~$ cd maven/
  - prod-user@ip-172-31-14-184:~/maven$ vi docker-compose.yml

## docker-compose.yml

```
version: '3'
services:
maven:
image: "zabdielv/$IMAGE:$TAG"
container_name: maven-app
```

- In Jenkins create new credential $PASS (password for docker hub used to upload images to repository)

- Copy private key of host machine to jenkins docker (so jenkins pipeline can ssh to remote machine):
  `docker cp /opt/prod jenkins:/opt/prod`

- Enter to jenkins docker and execute following command
  `ssh -i /opt/prod prod-user@$REMOTE_HOST` once.

- Update remote machine ip in Jenkinsfile.

  - Gloval env $REMOTE_HOST

- Make sure all files ownership are 1000:1000 (jenkins) and execution permision are chmod 755

## Deployments

- Commands in remote machine (AWS EC2) are executed with ssh. It can be done with AWS CLI or equivalent CLI.
