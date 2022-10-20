# Exceptions

Every design comes with some constraints - even/especially with Google/GKE. The below issues are some (but certainly not all of) the wierdness encountered and for which had to be solved.

### GKE controller/node version.

Anthos Service Mesh 1.14 supports the following [GKE versions]: `1.23`.

At present, the GKE module defaults to "latest"; `1.22.x` or thereabouts.

When using the modules they tend to have opinions. When using `release_channel="REGULAR"` as encouraged by all docs/code, the version cannot be passed to the module. Therefore, `release_channel="UNSPECIFIED"` must be used with `kubernetes_version="1.23.12-gke.100"` and `auto_upgrade = false`. 

Now, we can meet the minimum GKE version requirement of ASM.

[GKE versions]:https://cloud.google.com/service-mesh/docs/supported-platforms#114x
