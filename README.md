**_This project is still a work in progress... stay tuned for more._**

# Terraform Enterprise Demo Modules

This project aims to achieve the following two objectives:

1. Primarily, to demonstrate a best-practices pattern for structuring a module project while also taking into account testing requirements such as placement of test fixtures, controls/tests, profiles, etc.

2. Provide a collection of **_simple_** Terraform modules that can be used to deploy a **_demo_** Terraform Enterprise instance onto your cloud provider of choice (GCP, Azure, AWS —- see the appropriate `terraform-[gcp|azure|aws]` directory).

# GCP Example

Currently, the only example available in this project if for GCP. The below steps will help you get started.

## Prerequisites

Refer to the Kitchen-Terraform [installation instructions][kt-install]. This will walk you through installing Terraform, Ruby, Kitchen-Terraform and associated dependencies.

For this GCP example, you will first need to obtain a JSON credentials file as outlined here: https://cloud.google.com/docs/authentication/getting-started. These credentials will be used for both provisioning resources and running the `inspec-gcp` tests against provisioned resources.

You can set an the `GOOGLE_CREDENTIALS` environment variable to either the path to your JSON credentials file or to the full contents of the file. If using Terraform Cloud/Enterprise, you should use the latter approach, for example:

```bash
export GOOGLE_CREDENTIALS=$(cat CREDENTIALS_FILE.json | jq -c)
```

> Note that the `inspec-gcp` resource pack expects a credentials file path **_only_**, so if you set `GOOGLE_CREDENTIALS` to the credentials file content, you might also want to set an additional environment variable, `GOOGLE_APPLICATION_CREDENTIALS` with the path.

Here are the minimum setup steps if you're starting with a base Ubuntu box (e.g. `ubuntu/bionic64` Vagrant box):

```bash
# Update packages
sudo apt update && sudo apt -y upgrade

# Install Terraform
sudo apt -y install unzip && \
  curl -O https://releases.hashicorp.com/terraform/0.12.3/terraform_0.12.3_linux_amd64.zip && \
  sudo unzip terraform_0.12.3_linux_amd64.zip -d /usr/local/bin/

# Install rbenv & ruby-build plugin
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo -e '\nexport PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo -e 'eval "$(rbenv init -)"' >> ~/.bashrc
. ~/.bashrc
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

# Install Ruby
rbenv install 2.6.3
rbenv global 2.6.3

# Install Bundler
gem install bundler

# Install Google SDK
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
apt-get install apt-transport-https ca-certificates
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-sdk
```


## Get Started 

1. Clone this repo

1. Switch to the `terraform-gcp/` folder

1. Run Kitchen-Terraform:
    
    - The following four phases make up the Kitchen-Terraform lifecycle:
        1. `bundle exec kitchen create` creates and prepares the _local_ TF workspace in which TF state will be created, isolated from any other possible state present in the working folder
        
        1. `bundle exec kitchen converge` deploys the resources configured, based on the `suites` & `platforms` defined in your `kitchen.yml` file (`kitchen-terraform-[suite_name]-[platform_name]`)
        
        1. `bundle exec kitchen verify` runs the defined tests for each workspace (aka Kitchen-Terraform instance)
        
        1. `bundle exec kitchen destroy` destroys all resources created in the `converge` phase
    
    - Once these phases are complete, you'll have the output as to whether tests have passed or failed. When automated, you can use the results to determine next steps (more on this part coming soon)
    

[kt-install]: https://github.com/newcontext-oss/kitchen-terraform#installation