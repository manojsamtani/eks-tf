module "eks_cluster" {
  source                    = "./cluster"
  env                       = var.env
  eks_cluster_name          = var.cluster_map["name"]
  eks_cluster_version       = var.cluster_map["vers"]
  enabled_cluster_log_types = split(",", var.cluster_map["enable_log_types"])
  subnet_ids                = split(",", var.cluster_map["subnet_ids"])
  security_group_ids        = split(",", var.cluster_map["security_group_ids"])
}

module "eks_cluster_ng" {
  depends_on = [
    module.eks_cluster
  ]
  count              = var.cluster_map["managed_node_groups"] == "true" ? length(var.nodegroup_map) : 0
  source             = "./nodegroup"
  env                = var.env
  eks_cluster_name   = var.cluster_map["name"]
  eks_nodegroup_name = "${var.cluster_map["name"]}-ng-${count.index}"
  subnets_list       = split(",", var.nodegroup_map[count.index]["subnet_ids"]) 
  
  ng_max_size        = var.nodegroup_map[count.index]["max_size"]
  ng_min_size        = var.nodegroup_map[count.index]["min_size"]
  ng_desired_size    = var.nodegroup_map[count.index]["desired_size"]
  ng_max_unavailable = var.nodegroup_map[count.index]["max_unavailable"]
  
  ng_ami_type        = var.nodegroup_map[count.index]["ami_type"]
  ng_capacity_type   = var.nodegroup_map[count.index]["capacity_type"]

  ng_instance_types  = split(",", var.nodegroup_map[count.index]["instance_types"])
  ng_disk_size       = tonumber(var.nodegroup_map[count.index]["disk_size"])
}
