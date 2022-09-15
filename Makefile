#!/usr/bin/env make
# vim: tabstop=8 noexpandtab

# Grab some ENV stuff
TF_VAR_project	?= $(shell $(TF_VAR_project))
TF_VAR_envBuild 	?= $(shell $(TF_VAR_envBuild))


# Prep the project                                                               
prep:   ## Prepare for the build
	@scripts/setup/set-project-params.sh
	@printf '\n\n%s\n\n' "IF THIS LOOKS CORRECT YOU ARE CLEAR TO TERRAFORM" 

# Start Terraforming
all:	init plan apply

init:	## Initialze the build
	terraform init -get=true -backend=true -upgrade=true -reconfigure

plan:	## Initialze and Plan the build with output log
	terraform fmt -recursive=true
	terraform plan -no-color 2>&1 | \
		tee /tmp/tf-$(TF_VAR_project)-plan.out

apply:	## Build Terraform project with output log
	terraform apply --auto-approve -no-color \
		-input=false 2>&1 | \
		tee /tmp/tf-$(TF_VAR_project)-apply.out

addr:	## Retrieve the public_ip address from the Instance
	terraform state show module.compute.aws_instance.test_instance | grep 'public_ip' | grep -v associate_public_ip_address

state:	## View the Terraform State File in VS-Code
	@scripts/view-tf-state.sh

clean:	## Clean WARNING Message
	@echo ""
	@echo "Destroy $(TF_VAR_project)?"
	@echo ""
	@echo "    ***** STOP, THINK ABOUT THIS *****"
	@echo "You're about to DESTROY ALL that we have built"
	@echo ""
	@echo "IF YOU'RE CERTAIN, THEN 'make clean-all'"
	@echo ""
	@exit

clean-all:	## Destroy Terraformed resources and all generated files with output log
	terraform apply -destroy -auto-approve -no-color 2>&1 | \
	 	tee /tmp/tf-$(TF_VAR_project)-destroy.out
	rm -f "$(filePlan)"
	#rm -rf .terraform/ .terraform.lock.hcl

#-----------------------------------------------------------------------------#
#------------------------   MANAGERIAL OVERHEAD   ----------------------------#
#-----------------------------------------------------------------------------#
print-%  : ## Print any variable from the Makefile (e.g. make print-VARIABLE);
	@echo $* = $($*)

.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help

