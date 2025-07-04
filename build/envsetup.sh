function __print_build_functions_help() {
cat <<EOF
Additional Build functions:
- breakfast:       Setup the build environment, but only list
                   devices we support.
- cout:            Changes directory to out.
- mka:             Builds using SCHED_BATCH on all processors.
- pushboot:        Push a file from your OUT dir to your phone and
                   reboots it, using absolute path.
- repopick:        Utility to fetch changes from Gerrit.
EOF
}

function breakfast()
{
    target=$1
    local variant=$2
    source ${ANDROID_BUILD_TOP}/vendor/twrp/vars/aosp_target_release
    CUSTOM_DEVICES_ONLY="true"
    unset LUNCH_MENU_CHOICES
    add_lunch_combo full-eng
    for f in `/bin/ls device/*/*/vendorsetup.sh 2> /dev/null`
        do
            echo "including $f"
            . $f
        done
    unset f

    if [ $# -eq 0 ]; then
        # No arguments, so let's have the full menu
        lunch
    else
        echo "z$target" | grep -q "-"
        if [ $? -eq 0 ]; then
            # A buildtype was specified, assume a full device name
            lunch $target
        else
            # This is probably just the model name
            if [ -z "$variant" ]; then
                variant="userdebug"
            fi
            lunch twrp_$target-$aosp_target_release-$variant
        fi
    fi
    return $?
}

alias bib=breakfast

function cout()
{
    if [  "$OUT" ]; then
        cd $OUT
    else
        echo "Couldn't locate out directory.  Try setting OUT."
    fi
}

function fixup_common_out_dir() {
    common_out_dir=$(_get_build_var_cached OUT_DIR)/target/common
    target_device=$(_get_build_var_cached TARGET_DEVICE)
    if [ ! -z $ANDROID_FIXUP_COMMON_OUT ]; then
        if [ -d ${common_out_dir} ] && [ ! -L ${common_out_dir} ]; then
            mv ${common_out_dir} ${common_out_dir}-${target_device}
            ln -s ${common_out_dir}-${target_device} ${common_out_dir}
        else
            [ -L ${common_out_dir} ] && rm ${common_out_dir}
            mkdir -p ${common_out_dir}-${target_device}
            ln -s ${common_out_dir}-${target_device} ${common_out_dir}
        fi
    else
        [ -L ${common_out_dir} ] && rm ${common_out_dir}
        mkdir -p ${common_out_dir}
    fi
}

# Make using all available CPUs
function mka() {
    m "$@"
}

function pushboot() {
    if [ ! -f $OUT/$* ]; then
        echo "File not found: $OUT/$*"
        return 1
    fi

    adb root
    sleep 1
    adb wait-for-device
    adb remount

    adb push $OUT/$* /$*
    adb reboot
}

function repopick() {
    set_stuff_for_environment
    T=$(gettop)
    $T/vendor/twrp/build/tools/repopick.py $@
}

function aospremote()
{
    if ! git rev-parse --git-dir &> /dev/null
    then
        echo ".git directory not found. Please run this from the root directory of the Android repository you wish to set up."
        return 1
    fi
    git remote rm aosp 2> /dev/null

    if [ -f ".gitupstream" ]; then
        local REMOTE=$(cat .gitupstream | cut -d ' ' -f 1)
        git remote add aosp ${REMOTE}
    else
        local PROJECT=$(pwd -P | sed -e "s#$ANDROID_BUILD_TOP\/##; s#-caf.*##; s#\/default##")
        # Google moved the repo location in Oreo
        if [ $PROJECT = "build/make" ]
        then
            PROJECT="build"
        fi
        if (echo $PROJECT | grep -qv "^device")
        then
            local PFX="platform/"
        fi
        git remote add aosp https://android.googlesource.com/$PFX$PROJECT
    fi
    echo "Remote 'aosp' created"
}

function cloremote()
{
    if ! git rev-parse --git-dir &> /dev/null
    then
        echo ".git directory not found. Please run this from the root directory of the Android repository you wish to set up."
        return 1
    fi
    git remote rm clo 2> /dev/null

    if [ -f ".gitupstream" ]; then
        local REMOTE=$(cat .gitupstream | cut -d ' ' -f 1)
        git remote add clo ${REMOTE}
    else
        local PROJECT=$(pwd -P | sed -e "s#$ANDROID_BUILD_TOP\/##; s#-caf.*##; s#\/default##")
        # Google moved the repo location in Oreo
        if [ $PROJECT = "build/make" ]
        then
            PROJECT="build_repo"
        fi
        if [[ $PROJECT =~ "qcom/opensource" ]];
        then
            PROJECT=$(echo $PROJECT | sed -e "s#qcom\/opensource#qcom-opensource#")
        fi
        if (echo $PROJECT | grep -qv "^device")
        then
            local PFX="platform/"
        fi
        git remote add clo https://git.codelinaro.org/clo/la/$PFX$PROJECT
    fi
    echo "Remote 'clo' created"
}

# Set $TOP
export TOP=$(gettop)

# Enable SD-LLVM if available
if [ -d $(gettop)/vendor/qcom/sdclang ]; then
            export SDCLANG=true
            export SDCLANG_PATH="vendor/qcom/sdclang/4.0.2/prebuilt/linux-x86_64/bin"
            export SDCLANG_LTO_DEFS="vendor/qcom/sdclang/sdllvm-lto-defs.mk"
            export SDCLANG_CONFIG="vendor/qcom/sdclang/sdclang.json"
            export SDCLANG_AE_CONFIG="vendor/qcom/sdclang/sdclangAE.json"
fi

# Empty the vts makefile
if [ -s $(gettop)/frameworks/base/services/core/xsd/vts/Android.mk ]; then
	echo -n "" > $(gettop)/frameworks/base/services/core/xsd/vts/Android.mk
fi
