# Requirements

This is/should be a simple cluster used for learning. The top-most goal is designing for efficient GitOps patterns; all else are secondary in support of that. Of course, all are important to learn/know. 

This cluster must support: (all the things I'd like to experiment with); these are the **REQUIREMENTS**:

1. Quick/easy terraform `apply` and `destroy`
   1. build it, experiment, learn from it and tear it down daily
   2. maximize learning, minimize costs
2. a GitOps work-style (top-most requirement)
3. Anthos Service Mesh
   1. This used to be Istio but _The Times They Are A-Changin'_; we must keep up.
4. Fleet Management
   1. Still trying to determine if this is even necessary for a single cluster scenario.
   2. Seems sill to have a fleet of 1 but what do I know?!
5. a Kubernetes cluster to manage all of these shenanigans.
6. a _somewhat_ professional setup that should represent anything we might see out in the wild. To that end, we need just enough:
    1. networking: to support Kubernetes; I.E.: this is not about networking
       1. a Global VPC with a single giant subnet.
    2. identity management: because it's a real concern for which we must account.
