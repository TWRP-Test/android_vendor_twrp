add_json_str_omitempty = $(if $(strip $(2)),$(call add_json_str, $(1), $(2)))

_json_contents := $(_json_contents)    "Twrp":{$(newline)

# See build/core/soong_config.mk for the add_json_* functions you can use here.
$(call add_json_str_omitempty, Target_init_vendor_lib, 	      $(TARGET_INIT_VENDOR_LIB))
$(call add_json_bool, Target_enforce_ab_ota_partition_list,   $(filter true,$(TARGET_ENFORCE_AB_OTA_PARTITION_LIST)))

# This causes the build system to strip out the last comma in our nested struct, to keep the JSON valid.
_json_contents := $(_json_contents)__SV_END

_json_contents := $(_json_contents)    },$(newline)
