PATH_OVERRIDE_SOONG := $(shell echo $(TOOLS_PATH_OVERRIDE))

# Add variables that we wish to make available to soong here.
EXPORT_TO_SOONG := \
    KERNEL_ARCH \
    KERNEL_BUILD_OUT_PREFIX \
    KERNEL_CROSS_COMPILE \
    KERNEL_MAKE_CMD \
    KERNEL_MAKE_FLAGS \
    PATH_OVERRIDE_SOONG \
    TARGET_KERNEL_CONFIG \
    TARGET_KERNEL_HEADERS_SOURCE

# Setup SOONG_CONFIG_* vars to export the vars listed above.
# Documentation here:
# https://github.com/LineageOS/android_build_soong/commit/8328367c44085b948c003116c0ed74a047237a69

SOONG_CONFIG_NAMESPACES += twrpVarsPlugin

SOONG_CONFIG_twrpVarsPlugin :=

define addVar
  SOONG_CONFIG_twrpVarsPlugin += $(1)
  SOONG_CONFIG_twrpVarsPlugin_$(1) := $$(subst ",\",$$($1))
endef

$(foreach v,$(EXPORT_TO_SOONG),$(eval $(call addVar,$(v))))

SOONG_CONFIG_NAMESPACES += twrpGlobalVars
SOONG_CONFIG_twrpGlobalVars += \
    legacy_hw_disk_encryption \
    target_enforce_ab_ota_partition_list \
    gralloc_handle_has_reserved_size \
    target_init_vendor_lib \
    supports_hw_fde \
    supports_hw_fde_perf

ifeq ($(TARGET_HW_DISK_ENCRYPTION),true)
SOONG_CONFIG_twrpGlobalVars += \
    hw_fde_cryptfs_hw_header_lib_name \
    hw_fde_cryptfs_hw_shared_lib_name
endif

# Soong bool variables
SOONG_CONFIG_twrpGlobalVars_gralloc_handle_has_reserved_size := $(TARGET_GRALLOC_HANDLE_HAS_RESERVED_SIZE)
SOONG_CONFIG_twrpGlobalVars_legacy_hw_disk_encryption := $(TARGET_LEGACY_HW_DISK_ENCRYPTION)
SOONG_CONFIG_twrpGlobalVars_target_enforce_ab_ota_partition_list := $(TARGET_ENFORCE_AB_OTA_PARTITION_LIST)
SOONG_CONFIG_twrpGlobalVars_supports_hw_fde := $(TARGET_HW_DISK_ENCRYPTION)
SOONG_CONFIG_twrpGlobalVars_supports_hw_fde_perf := $(TARGET_HW_DISK_ENCRYPTION_PERF)

ifneq ($(TARGET_CRYPTFS_HW_PATH),)
  SOONG_CONFIG_twrpGlobalVars_hw_fde_cryptfs_hw_header_lib_name := //$(TARGET_CRYPTFS_HW_PATH):libcryptfs_hw_headers
  SOONG_CONFIG_twrpGlobalVars_hw_fde_cryptfs_hw_shared_lib_name := //$(TARGET_CRYPTFS_HW_PATH):libcryptfs_hw
else
  SOONG_CONFIG_twrpGlobalVars_hw_fde_cryptfs_hw_header_lib_name := libcryptfs_hw_headers
  SOONG_CONFIG_twrpGlobalVars_hw_fde_cryptfs_hw_shared_lib_name := libcryptfs_hw
endif

# Set default values
TARGET_GRALLOC_HANDLE_HAS_RESERVED_SIZE ?= false
TARGET_INIT_VENDOR_LIB ?= vendor_init

# Soong value variables
SOONG_CONFIG_twrpGlobalVars_target_init_vendor_lib := $(TARGET_INIT_VENDOR_LIB)
