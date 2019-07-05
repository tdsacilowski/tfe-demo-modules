**_This project is still a work in progress... stay tuned for more._**

# Terraform Enterprise Demo Modules

This project aims to achieve the following two objectives:

1. Primarily, to demonstrate a best-practices pattern for structuring a module project while also taking into account testing requirements such as placement of test fixtures, controls/tests, profiles, etc.

2. Provide a collection of **_simple_** Terraform modules that can be used to deploy a **_demo_** Terraform Enterprise instance onto your cloud provider of choice (GCP, Azure, AWS —- see the appropriate `terraform-[gcp|azure|aws]` directory).

# Get Started

1. Refer to the Kitchen-Terraform [installation instructions][kt-install].
    - This will walk you through installing Terraform, Ruby, Kitchen-Terraform and associated dependencies.

2. Clone this repo

3. Switch to the `terraform-gcp/` folder

4. Run Kitchen-Terraform:
    - The following four phases make up the Kitchen-Terraform lifecycle:
        1. `bundle exec kitchen create` creates and prepares the _local_ TF workspace in which TF state will be created, isolated from any other possible state present in the working folder
        2. `bundle exec kitchen converge` deploys the resources configured, based on the `suites` & `platforms` defined in your `kitchen.yml` file (`kitchen-terraform-[suite_name]-[platform_name]`)
        3. `bundle exec kitchen verify` runs the defined tests for each workspace (aka Kitchen-Terraform instance)
        4. `bundle exec kitchen destroy` destroys all resources created in the `converge` phase
    - Once these phases are complete, you'll have the output as to whether tests have passed or failed. When automated, you can use the results to determine next steps (more on this part coming soon)
    

[kt-install]: https://github.com/newcontext-oss/kitchen-terraform#installation