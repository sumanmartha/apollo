# apollo

Requirements for running this project
1. terraform latest
2. ansible latest
3. google cloud account
4. TestKeyPair placed in ~/.ssh folder


Steps to run

- Create docker images using Dockerfile in gke folder and push image to your docker hub or google cloud container registry
    $ cd gke
    $ docker build -t sumanmartha/apollo .
    $ docker push sumanmartha/apollo
    or we can use google container registry https://cloud.google.com/container-registry/docs/pushing-and-pulling?_ga=2.162536831.-219227474.1593571072
- configure google cloud authentication (https://cloud.google.com/docs/authentication/getting-started)
  $ export GOOGLE_APPLICATION_CREDENTIALS="/home/user/Downloads/my-key.json" 
  $ cd ..
  $ terraform init
  $ terraform apply (this will create instance in google cloud and host nginx server)

- Create gke cluster (we can create cluster and instance at same time but I used in 2 steps)
  $ cd gke
  $ terraform init
  $ terraform apply

- Deploy application in gke
  -> Go to Kubernetes cluster in GKE console (we can automate this process)
  -> Select hosted cluster
  -> Select deploy app
  -> Change image to sumanmartha/apollo
  -> Select Continue option and Click on Deploy option to deploy

  