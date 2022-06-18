# ITC - Terraform Project Template

[![license](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
![CI workflow](https://github.com/indigo-tangerine/itc-tfm-project-template/actions/workflows/ci-pr.yml/badge.svg)
![CD workflow](https://github.com/indigo-tangerine/itc-tfm-project-template/actions/workflows/cd.yml/badge.svg)

## Change this line

![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/indigo-tangerine/itc-tfm-project-template)

## Stuff that needs to be updated/changed

* Organization and repository names in lines 3 and 4 above. This ensures the badges display the correct values.
* configuration/main.backend.tfvars
  * Terraform state file name ("key" variable)
* configuration/main.tfvars
  * AWS Account ID ("aws_account_id" variable)
  * DTAP environment or deployment target ("stage" variable)
  * AWS Region ("aws_region" variable)
  * Client short name/code, if applicable ("client" variable)
* variables.tf
  * Project, application or service name ("service" variable)
  * Github organization name ("github_org" variable)
* backend.tf
  * Terraform state bucket name
  * Dynamodb state lock table name
* locals.tf
  * CICD automation role name ("cicd_automation_role_name" variable)

## Configuration

Every environments or deployment targets needs two files: main.tfvars and main.backend.tfvars.

* main.tfvars
  * contains envrionment specific and/or project variables
  * account_id ensures resources are deployed to the correct account
  * stage defines the DTAP environment

* main.backend.tfvars
  * partial configuration of terraform "backend"
  * specifies the terraform state file name that will be created in S3

Configurations can be created in several different ways:

### One Configuration

For simple projects where there is only one environment or deployment target.

|- configuration
    |-  main.tfvars
        main.backend.tfvars

### Single-tenant DTAP environments

Folder names are not fixed.

|- configuration
    |- dev
        |-  main.tfvars
            main.backend.tfvars
    |- tst
        |-  main.tfvars
            main.backend.tfvars
    |- acc
        |-  main.tfvars
            main.backend.tfvars
    |- prd
        |-  main.tfvars
            main.backend.tfvars

### Multi-tenant DTAP environments

|- configuration
    |- client_aaa
        |- dev
            |-  main.tfvars
                main.backend.tfvars
        |- tst
            |-  main.tfvars
                main.backend.tfvars
        |- acc
            |-  main.tfvars
                main.backend.tfvars
        |- prd
            |-  main.tfvars
                main.backend.tfvars
    |- client_bbb
        |- dev
            |-  main.tfvars
                main.backend.tfvars
        |- tst
            |-  main.tfvars
                main.backend.tfvars
        |- acc
            |-  main.tfvars
                main.backend.tfvars
        |- prd
            |-  main.tfvars
                main.backend.tfvars
