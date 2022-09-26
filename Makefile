#!/usr/bin/env make
# vim: tabstop=8 noexpandtab

# Grab some ENV stuff
TF_VAR_project	?= $(shell $(TF_VAR_project))
TF_VAR_envBuild	?= $(shell $(TF_VAR_envBuild))


# Prep the project                                                               
prep:   ## Prepare for the build
	@scripts/setup/set-project-params.sh
	@printf '\n\n%s\n\n' "IF THIS LOOKS CORRECT YOU ARE CLEAR TO TERRAFORM" 

# Start Terraforming
all:	init plan apply creds ingrss

init:	## Initialze the build
	terraform init -get=true -backend=true -upgrade=true -reconfigure

plan:	## Initialze and Plan the build with output log
	terraform fmt -recursive=true
	terraform plan -no-color 2>&1 | \
		tee /tmp/tf-$(TF_VAR_project)-plan.out

apply:	## Build Terraform project with output log
	terraform apply --auto-approve -no-color \
		-parallelism=20 -input=false 2>&1 | \
		tee /tmp/tf-$(TF_VAR_project)-apply.out

creds:	## Retrieve the KUBECONFIG file
	@scripts/get-creds.sh

ingrss:	## addons/ingress/istio/istio-install.sh 
	@addons/istio/istio-install.sh
	#@addons/istio/kiali/kiali-install.sh

# ------------------- make all ends here -------------------------------------

ingdmo:	## 
	@addons/ingress/istio/istio-demo.sh

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
	@echo "IF YOU'RE CERTAIN, THEN 'make destroy'"
	@echo ""
	@exit

destroy:	## Destroy Terraformed resources and all generated files with output log
	scripts/destroyer.sh 

#-----------------------------------------------------------------------------#
#------------------------   MANAGERIAL OVERHEAD   ----------------------------#
#-----------------------------------------------------------------------------#
print-%  : ## Print any variable from the Makefile (e.g. make print-VARIABLE);
	@echo $* = $($*)

.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help

