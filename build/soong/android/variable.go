package android

type Product_variables struct {
    Target_enforce_ab_ota_partition_list struct {
        Cflags []string
    }
}

type ProductVariables struct {
    Target_enforce_ab_ota_partition_list    *bool `json:",omitempty"`
}
