PATH_OVERRIDE_SOONG := $(shell echo $(TOOLS_PATH_OVERRIDE))

# Normalize scalars only; exported C strings remain raw.
twrp_scalar = $(strip $(patsubst "%",%,$(strip $(1))))

# Add variables that we wish to make available to soong here.
EXPORT_TO_SOONG := \
    KERNEL_ARCH \
    KERNEL_BUILD_OUT_PREFIX \
    KERNEL_CROSS_COMPILE \
    KERNEL_MAKE_CMD \
    KERNEL_MAKE_FLAGS \
    PATH_OVERRIDE_SOONG \
    TARGET_KERNEL_CONFIG \
    TARGET_PREBUILT_KERNEL \
    TARGET_KERNEL_SOURCE \
    TARGET_KERNEL_HEADERS_SOURCE \
    TW_THEME \
    TW_CUSTOM_THEME \
    DEVICE_RESOLUTION \
    TARGET_SCREEN_WIDTH \
    TARGET_SCREEN_HEIGHT \
    TARGET_RECOVERY_PIXEL_FORMAT \
    TW_EXTRA_LANGUAGES \
    TW_INCLUDE_WIFI \
    TWRP_CUSTOM_KEYBOARD \
    AB_OTA_UPDATER \
    TW_TARGET_USES_QCOM_BSP \
    TARGET_RECOVERY_FORCE_PIXEL_FORMAT \
    TW_INCLUDE_JPEG \
    TW_ROTATION \
    BOARD_HAS_FLIPPED_SCREEN \
    TW_HAPTICS_TSPDRV \
    TW_SUPPORT_INPUT_AIDL_HAPTICS \
    TW_SUPPORT_INPUT_1_2_HAPTICS \
    TW_STATUS_ICONS_ALIGN \
    TW_CUSTOM_BATTERY_POS \
    TW_CUSTOM_CLOCK_POS \
    TW_CUSTOM_CPU_POS \
    TW_OZIP_DECRYPT_KEY \
    TW_LOAD_VENDOR_MODULES \
    TW_LOAD_VENDOR_MODULES_EXCLUDE_GKI \
    TW_LOAD_VENDOR_BOOT_MODULES \
    TW_SYSTEM_BUILD_PROP_ADDITIONAL_PATHS \
    TW_INTERNAL_STORAGE_PATH \
    TW_EXTERNAL_STORAGE_PATH \
    TW_CUSTOM_POWER_BUTTON \
    TARGET_USE_CUSTOM_LUN_FILE_PATH \
    TW_ADDITIONAL_APEX_FILES \
    TW_BRIGHTNESS_PATH \
    TW_SECONDARY_BRIGHTNESS_PATH \
    TW_CUSTOM_BATTERY_PATH \
    TW_CUSTOM_CPU_TEMP_PATH \
    TW_OVERRIDE_SYSTEM_PROPS \
    TW_OVERRIDE_PROPS_ADDITIONAL_PARTITIONS \
    TARGET_OTA_ASSERT_DEVICE \
    TW_BACKUP_EXCLUSIONS \
    BOARD_BOOT_HEADER_VERSION \
    TARGET_RECOVERY_TWRP_LIB \
    TARGET_CUSTOM_KERNEL_HEADERS \
    TW_DRM_TWO_STAGE_MODESET \
    TW_LIBTAR_DEBUG \
    TW_INCLUDE_CRYPTO_FBE \
    TW_USE_FSCRYPT_POLICY \
    TW_LOAD_PREBUILT_MODULES_AT_FIRST \
    TW_INPUT_BLACKLIST \
    TW_WHITELIST_INPUT \
    TW_SUPPORT_INPUT_AIDL_HAPTICS_FQNAME \
    TW_DEFAULT_LANGUAGE \
    TW_DEVICE_VERSION \
    TW_GIT_REVISION \
    USB_MTP_DEVICE \
    TW_QCOM_ATS_OFFSET \
    TW_CLOCK_OFFSET \
    TW_USE_KEY_CODE_TOUCH_SYNC

SOONG_CONFIG_NAMESPACES += twrpVarsPlugin

SOONG_CONFIG_twrpVarsPlugin :=

define addVar
  SOONG_CONFIG_twrpVarsPlugin += $(1)
  SOONG_CONFIG_twrpVarsPlugin_$(1) := $($1)
endef

SOONG_CONFIG_NAMESPACES += twrpGlobalVars
SOONG_CONFIG_twrpGlobalVars += \
    target_enforce_ab_ota_partition_list \
    tw_delay_touch_init_ms \
    tw_event_logging \
    tw_use_key_code_touch_sync \
    tw_no_screen_timeout \
    tw_x_offset \
    tw_y_offset \
    tw_w_offset \
    tw_h_offset \
    tw_framerate \
    tw_round_screen \
    twrp_custom_keyboard \
    tw_support_input_1_2_haptics \
    tw_target_uses_qcom_bsp \
    tw_include_jpeg \
    recovery_touchscreen_swap_xy \
    recovery_touchscreen_flip_x \
    recovery_touchscreen_flip_y \
    recovery_graphics_force_use_linelength \
    recovery_graphics_force_single_buffer \
    twrp_event_logging \
    target_recovery_overscan_percent \
    tw_screen_blank_on_boot \
    tw_fbiopan \
    tw_ignore_major_axis_0 \
    tw_ignore_mt_position_0 \
    tw_haptics_tspdrv \
    tw_support_input_aidl_haptics \
    tw_support_input_aidl_haptics_fix_off \
    tw_use_samsung_haptics \
    tw_use_meizu_touch_mapping \
    use_dynamic_partition \
    move_recovery_res_to_vendor_boot \
    exclude_apex \
    include_resetprop \
    include_libresetprop \
    include_crypto \
    include_crypto_fbe \
    include_se_omapi \
    ab_ota_updater \
    include_lpdump \
    include_lptools \
    uses_vendor_libs \
    no_flash_current_twrp \
    prepare_data_media_early \
    enable_fs_compression \
    has_mtp \
    has_no_real_sdcard \
    sdcard_on_data \
    no_boot_partition \
    no_reboot_bootloader \
    no_reboot_recovery \
    no_battery_percent \
    no_cpu_temperature \
    always_rmrf \
    no_usb_storage \
    has_download_mode \
    has_edl_mode \
    no_screen_blank \
    sdext_no_ext4 \
    no_haptics \
    use_dmctl \
    include_7za \
    include_zstd \
    workaround_backup_bug \
    use_serialno_prop_for_device_id \
    max_brightness \
    default_brightness \
    use_legacy_battery_services \
    qcom_rtc_fix \
    qcom_ats_offset \
    clock_offset \
    include_fastbootd \
    enable_blkdiscard \
    skip_additional_fstab \
    force_keymaster_version \
    avb_vbmeta_flags_all_disabled \
    exclude_tzdata \
    exclude_bash \
    exclude_nano \
    include_repacktools \
    exclude_default_usb_init \
    include_logcat \
    use_logd \
    recovery_device_modules \
    include_ntfs_3g \
    include_python \
    platform_sdk_version \
    include_wifi

# Defaults
TARGET_RECOVERY_OVERSCAN_PERCENT ?= 0
TW_X_OFFSET ?= 0
TW_Y_OFFSET ?= 0
TW_W_OFFSET ?= 0
TW_H_OFFSET ?= 0
TW_DELAY_TOUCH_INIT_MS ?= 0
TW_FRAMERATE ?= 30
TW_SUPPORT_INPUT_AIDL_HAPTICS_FQNAME ?= IVibrator/default
TW_DEVICE_VERSION ?= 0
TW_DEFAULT_LANGUAGE ?= en
TW_MAX_BRIGHTNESS ?= 255
TW_DEFAULT_BRIGHTNESS ?= 100

ifeq ($(call twrp_scalar,$(TW_FORCE_USE_BUSYBOX)), true)
    TW_USE_TOOLBOX := false
else
    TW_USE_TOOLBOX := true
endif

ifneq ($(filter-out "",$(strip $(TW_CUSTOM_BATTERY_PATH))),)
    TW_USE_LEGACY_BATTERY_SERVICES := true
endif

ifneq ($(filter-out "",$(strip $(TW_OVERRIDE_SYSTEM_PROPS))),)
    TW_INCLUDE_LIBRESETPROP := true
endif

ifneq ($(call twrp_scalar,$(TW_EXCLUDE_MTP)),true)
    TW_HAS_MTP := true
else
    TW_HAS_MTP := false
endif

ifeq ($(call twrp_scalar,$(PRODUCT_USE_DYNAMIC_PARTITIONS)), true)
    ifeq ($(call twrp_scalar,$(TW_ENABLE_ALL_PARTITION_TOOLS)), true)
        TW_INCLUDE_LPDUMP := true
        TW_INCLUDE_LPTOOLS := true
    endif
endif

# Soong variables
$(call soong_config_set_bool, twrpGlobalVars, target_enforce_ab_ota_partition_list, $(call twrp_scalar,$(TARGET_ENFORCE_AB_OTA_PARTITION_LIST)))

SOONG_CONFIG_twrpGlobalVars_tw_delay_touch_init_ms := $(call twrp_scalar,$(TW_DELAY_TOUCH_INIT_MS))
$(call soong_config_set_bool, twrpGlobalVars, tw_event_logging, $(call twrp_scalar,$(TW_EVENT_LOGGING)))
SOONG_CONFIG_twrpGlobalVars_tw_use_key_code_touch_sync := $(call twrp_scalar,$(TW_USE_KEY_CODE_TOUCH_SYNC))
$(call soong_config_set_bool, twrpGlobalVars, tw_no_screen_timeout, $(call twrp_scalar,$(TW_NO_SCREEN_TIMEOUT)))
SOONG_CONFIG_twrpGlobalVars_tw_x_offset := $(call twrp_scalar,$(TW_X_OFFSET))
SOONG_CONFIG_twrpGlobalVars_tw_y_offset := $(call twrp_scalar,$(TW_Y_OFFSET))
SOONG_CONFIG_twrpGlobalVars_tw_w_offset := $(call twrp_scalar,$(TW_W_OFFSET))
SOONG_CONFIG_twrpGlobalVars_tw_h_offset := $(call twrp_scalar,$(TW_H_OFFSET))
SOONG_CONFIG_twrpGlobalVars_tw_framerate := $(call twrp_scalar,$(TW_FRAMERATE))
$(call soong_config_set_bool, twrpGlobalVars, tw_round_screen, $(call twrp_scalar,$(TW_ROUND_SCREEN)))
SOONG_CONFIG_twrpGlobalVars_twrp_custom_keyboard := $(TWRP_CUSTOM_KEYBOARD)
$(call soong_config_set_bool, twrpGlobalVars, tw_support_input_1_2_haptics, $(call twrp_scalar,$(TW_SUPPORT_INPUT_1_2_HAPTICS)))
$(call soong_config_set_bool, twrpGlobalVars, tw_target_uses_qcom_bsp, $(call twrp_scalar,$(TW_TARGET_USES_QCOM_BSP)))
$(call soong_config_set_bool, twrpGlobalVars, tw_include_jpeg, $(call twrp_scalar,$(TW_INCLUDE_JPEG)))
$(call soong_config_set_bool, twrpGlobalVars, recovery_touchscreen_swap_xy, $(call twrp_scalar,$(RECOVERY_TOUCHSCREEN_SWAP_XY)))
$(call soong_config_set_bool, twrpGlobalVars, recovery_touchscreen_flip_x, $(call twrp_scalar,$(RECOVERY_TOUCHSCREEN_FLIP_X)))
$(call soong_config_set_bool, twrpGlobalVars, recovery_touchscreen_flip_y, $(call twrp_scalar,$(RECOVERY_TOUCHSCREEN_FLIP_Y)))
$(call soong_config_set_bool, twrpGlobalVars, recovery_graphics_force_use_linelength, $(call twrp_scalar,$(RECOVERY_GRAPHICS_FORCE_USE_LINELENGTH)))
$(call soong_config_set_bool, twrpGlobalVars, recovery_graphics_force_single_buffer, $(call twrp_scalar,$(RECOVERY_GRAPHICS_FORCE_SINGLE_BUFFER)))
$(call soong_config_set_bool, twrpGlobalVars, twrp_event_logging, $(call twrp_scalar,$(TWRP_EVENT_LOGGING)))
SOONG_CONFIG_twrpGlobalVars_target_recovery_overscan_percent := $(call twrp_scalar,$(TARGET_RECOVERY_OVERSCAN_PERCENT))
$(call soong_config_set_bool, twrpGlobalVars, tw_screen_blank_on_boot, $(call twrp_scalar,$(TW_SCREEN_BLANK_ON_BOOT)))
$(call soong_config_set_bool, twrpGlobalVars, tw_fbiopan, $(call twrp_scalar,$(TW_FBIOPAN)))
$(call soong_config_set_bool, twrpGlobalVars, tw_ignore_major_axis_0, $(call twrp_scalar,$(TW_IGNORE_MAJOR_AXIS_0)))
$(call soong_config_set_bool, twrpGlobalVars, tw_ignore_mt_position_0, $(call twrp_scalar,$(TW_IGNORE_MT_POSITION_0)))
$(call soong_config_set_bool, twrpGlobalVars, tw_haptics_tspdrv, $(call twrp_scalar,$(TW_HAPTICS_TSPDRV)))
$(call soong_config_set_bool, twrpGlobalVars, tw_support_input_aidl_haptics, $(call twrp_scalar,$(TW_SUPPORT_INPUT_AIDL_HAPTICS)))
$(call soong_config_set_bool, twrpGlobalVars, tw_support_input_aidl_haptics_fix_off, $(call twrp_scalar,$(TW_SUPPORT_INPUT_AIDL_HAPTICS_FIX_OFF)))
$(call soong_config_set_bool, twrpGlobalVars, tw_use_samsung_haptics, $(call twrp_scalar,$(TW_USE_SAMSUNG_HAPTICS)))
$(call soong_config_set_bool, twrpGlobalVars, tw_use_meizu_touch_mapping, $(call twrp_scalar,$(TW_USE_MEIZU_TOUCH_MAPPING)))

$(call soong_config_set_string_list, twrpGlobalVars, recovery_device_modules, $(TARGET_RECOVERY_DEVICE_MODULES))

git_revision := $(shell git -C bootable/recovery rev-parse --short=8 HEAD 2>/dev/null)
ifeq ($(shell git -C bootable/recovery diff --quiet; echo $$?),1)
    git_revision := $(git_revision)-dirty
endif
TW_GIT_REVISION := $(git_revision)

$(call soong_config_set_int, twrpGlobalVars, max_brightness, $(call twrp_scalar,$(TW_MAX_BRIGHTNESS)))
$(call soong_config_set_int, twrpGlobalVars, default_brightness, $(call twrp_scalar,$(TW_DEFAULT_BRIGHTNESS)))

$(call soong_config_set_int, twrpGlobalVars, qcom_ats_offset, $(call twrp_scalar,$(if $(call twrp_scalar,$(TW_QCOM_ATS_OFFSET)),$(call twrp_scalar,$(TW_QCOM_ATS_OFFSET)),0)))
$(call soong_config_set_int, twrpGlobalVars, clock_offset, $(call twrp_scalar,$(if $(call twrp_scalar,$(TW_CLOCK_OFFSET)),$(call twrp_scalar,$(TW_CLOCK_OFFSET)),0)))

$(call soong_config_set_int, twrpGlobalVars, platform_sdk_version, $(call twrp_scalar,$(PLATFORM_SDK_VERSION)))

ifeq ($(call twrp_scalar,$(TW_INCLUDE_CRYPTO)), true)
    TW_INCLUDE_CRYPTO_FBE := true
    TW_INCLUDE_LIBRESETPROP := true
else
    TW_INCLUDE_OMAPI := false
endif
$(call soong_config_set_bool, twrpGlobalVars, include_se_omapi, $(call twrp_scalar,$(TW_INCLUDE_OMAPI)))

$(call soong_config_set_bool, twrpGlobalVars, use_dynamic_partition, $(call twrp_scalar,$(if $(filter true,$(call twrp_scalar,$(PRODUCT_USE_DYNAMIC_PARTITIONS))),true,false)))
$(call soong_config_set_bool, twrpGlobalVars, move_recovery_res_to_vendor_boot, $(call twrp_scalar,$(if $(filter true,$(call twrp_scalar,$(BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT))),true,false)))
$(call soong_config_set_bool, twrpGlobalVars, use_serialno_prop_for_device_id, $(call twrp_scalar,$(TW_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID)))
$(call soong_config_set_bool, twrpGlobalVars, exclude_apex, $(call twrp_scalar,$(TW_EXCLUDE_APEX)))
$(call soong_config_set_bool, twrpGlobalVars, include_resetprop, $(call twrp_scalar,$(TW_INCLUDE_RESETPROP)))
$(call soong_config_set_bool, twrpGlobalVars, include_libresetprop, $(call twrp_scalar,$(TW_INCLUDE_LIBRESETPROP)))
$(call soong_config_set_bool, twrpGlobalVars, include_crypto, $(call twrp_scalar,$(TW_INCLUDE_CRYPTO)))
$(call soong_config_set_bool, twrpGlobalVars, include_crypto_fbe, $(call twrp_scalar,$(TW_INCLUDE_CRYPTO_FBE)))
$(call soong_config_set_bool, twrpGlobalVars, ab_ota_updater, $(call twrp_scalar,$(AB_OTA_UPDATER)))
$(call soong_config_set_bool, twrpGlobalVars, include_lpdump, $(call twrp_scalar,$(TW_INCLUDE_LPDUMP)))
$(call soong_config_set_bool, twrpGlobalVars, include_lptools, $(call twrp_scalar,$(TW_INCLUDE_LPTOOLS)))
$(call soong_config_set_bool, twrpGlobalVars, uses_vendor_libs, $(call twrp_scalar,$(TW_USES_VENDOR_LIBS)))
$(call soong_config_set_bool, twrpGlobalVars, no_flash_current_twrp, $(call twrp_scalar,$(TW_NO_FLASH_CURRENT_TWRP)))
$(call soong_config_set_bool, twrpGlobalVars, prepare_data_media_early, $(call twrp_scalar,$(TW_PREPARE_DATA_MEDIA_EARLY)))
$(call soong_config_set_bool, twrpGlobalVars, enable_fs_compression, $(call twrp_scalar,$(TW_ENABLE_FS_COMPRESSION)))
$(call soong_config_set_bool, twrpGlobalVars, has_mtp, $(call twrp_scalar,$(TW_HAS_MTP)))
$(call soong_config_set_bool, twrpGlobalVars, tw_no_screen_timeout, $(call twrp_scalar,$(TW_NO_SCREEN_TIMEOUT)))
$(call soong_config_set_bool, twrpGlobalVars, has_no_real_sdcard, $(call twrp_scalar,$(BOARD_HAS_NO_REAL_SDCARD)))
$(call soong_config_set_bool, twrpGlobalVars, sdcard_on_data, $(call twrp_scalar,$(RECOVERY_SDCARD_ON_DATA)))
$(call soong_config_set_bool, twrpGlobalVars, no_boot_partition, $(call twrp_scalar,$(TW_HAS_NO_BOOT_PARTITION)))
$(call soong_config_set_bool, twrpGlobalVars, no_reboot_bootloader, $(call twrp_scalar,$(TW_NO_REBOOT_BOOTLOADER)))
$(call soong_config_set_bool, twrpGlobalVars, no_reboot_recovery, $(call twrp_scalar,$(TW_NO_REBOOT_RECOVERY)))
$(call soong_config_set_bool, twrpGlobalVars, no_battery_percent, $(call twrp_scalar,$(TW_NO_BATT_PERCENT)))
$(call soong_config_set_bool, twrpGlobalVars, no_cpu_temperature, $(call twrp_scalar,$(TW_NO_CPU_TEMP)))
$(call soong_config_set_bool, twrpGlobalVars, always_rmrf, $(call twrp_scalar,$(TW_ALWAYS_RMRF)))
$(call soong_config_set_bool, twrpGlobalVars, never_umount_system, $(call twrp_scalar,$(TW_NEVER_UNMOUNT_SYSTEM)))
$(call soong_config_set_bool, twrpGlobalVars, no_usb_storage, $(call twrp_scalar,$(TW_NO_USB_STORAGE)))
$(call soong_config_set_bool, twrpGlobalVars, has_download_mode, $(call twrp_scalar,$(TW_HAS_DOWNLOAD_MODE)))
$(call soong_config_set_bool, twrpGlobalVars, has_edl_mode, $(call twrp_scalar,$(TW_HAS_EDL_MODE)))
$(call soong_config_set_bool, twrpGlobalVars, no_screen_blank, $(call twrp_scalar,$(TW_NO_SCREEN_BLANK)))
$(call soong_config_set_bool, twrpGlobalVars, sdext_no_ext4, $(call twrp_scalar,$(TW_SDEXT_NO_EXT4)))
$(call soong_config_set_bool, twrpGlobalVars, no_haptics, $(call twrp_scalar,$(TW_NO_HAPTICS)))
$(call soong_config_set_bool, twrpGlobalVars, use_dmctl, $(call twrp_scalar,$(TW_USE_DMCTL)))
$(call soong_config_set_bool, twrpGlobalVars, include_7za, $(call twrp_scalar,$(TW_INCLUDE_7ZA)))
$(call soong_config_set_bool, twrpGlobalVars, include_zstd, $(call twrp_scalar,$(TW_INCLUDE_ZSTD)))
$(call soong_config_set_bool, twrpGlobalVars, workaround_backup_bug, $(call twrp_scalar,$(TW_WORKAROUND_BACKUP_BUG)))
$(call soong_config_set_bool, twrpGlobalVars, use_serialno_prop_for_device_id, $(call twrp_scalar,$(TW_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID)))
$(call soong_config_set_bool, twrpGlobalVars, use_legacy_battery_services, $(call twrp_scalar,$(TW_USE_LEGACY_BATTERY_SERVICES)))
$(call soong_config_set_bool, twrpGlobalVars, qcom_rtc_fix, $(call twrp_scalar,$(TARGET_RECOVERY_QCOM_RTC_FIX)))
$(call soong_config_set_bool, twrpGlobalVars, exclude_nano, $(call twrp_scalar,$(TW_EXCLUDE_NANO)))
$(call soong_config_set_bool, twrpGlobalVars, include_fastbootd, $(call twrp_scalar,$(TW_INCLUDE_FASTBOOTD)))
$(call soong_config_set_bool, twrpGlobalVars, enable_blkdiscard, $(call twrp_scalar,$(TW_ENABLE_BLKDISCARD)))
$(call soong_config_set_bool, twrpGlobalVars, skip_additional_fstab, $(call twrp_scalar,$(TW_SKIP_ADDITIONAL_FSTAB)))
$(call soong_config_set_bool, twrpGlobalVars, force_keymaster_version, $(call twrp_scalar,$(TW_FORCE_KEYMASTER_VER)))
$(call soong_config_set_bool, twrpGlobalVars, avb_vbmeta_flags_all_disabled, $(call twrp_scalar,$(TW_AVB_VBMETA_FLAGS_ALL_DISABLED)))
$(call soong_config_set_bool, twrpGlobalVars, exclude_tzdata, $(call twrp_scalar,$(TW_EXCLUDE_TZDATA)))
$(call soong_config_set_bool, twrpGlobalVars, exclude_bash, $(call twrp_scalar,$(TW_EXCLUDE_BASH)))
$(call soong_config_set_bool, twrpGlobalVars, include_repacktools, $(call twrp_scalar,$(TW_INCLUDE_REPACKTOOLS)))
$(call soong_config_set_bool, twrpGlobalVars, exclude_default_usb_init, $(call twrp_scalar,$(TW_EXCLUDE_DEFAULT_USB_INIT)))
$(call soong_config_set_bool, twrpGlobalVars, include_logcat, $(call twrp_scalar,$(TWRP_INCLUDE_LOGCAT)))
$(call soong_config_set_bool, twrpGlobalVars, use_logd, $(call twrp_scalar,$(TARGET_USES_LOGD)))
$(call soong_config_set_bool, twrpGlobalVars, include_ntfs_3g, $(call twrp_scalar,$(TW_INCLUDE_NTFS_3G)))
$(call soong_config_set_bool, twrpGlobalVars, include_python, $(call twrp_scalar,$(TW_INCLUDE_PYTHON)))
$(call soong_config_set_bool, twrpGlobalVars, include_wifi, $(call twrp_scalar,$(TW_INCLUDE_WIFI)))

# Vendor init
ifneq ($(TARGET_INIT_VENDOR_LIB),)
    $(call soong_config_set,libinit,vendor_init_lib,$(TARGET_INIT_VENDOR_LIB))
endif

# Export after defaults and inferred feature values are resolved.
$(foreach v,$(EXPORT_TO_SOONG),$(eval $(call addVar,$(v))))

# system/vold reads the selector from the legacy makeVarsPlugin namespace.
SOONG_CONFIG_NAMESPACES += makeVarsPlugin
SOONG_CONFIG_makeVarsPlugin += TW_USE_FSCRYPT_POLICY
SOONG_CONFIG_makeVarsPlugin_TW_USE_FSCRYPT_POLICY := $(call twrp_scalar,$(TW_USE_FSCRYPT_POLICY))
