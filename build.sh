#!/bin/bash
rm -rf .repo/local_manifests/
rm -rf .repo/repo/
repo init --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 16 -g default,-mips,-darwin,-notdefault
/opt/crave/resync.sh
git clone https://github.com/hxfuxyy/android_device_xiaomi_nabu device/xiaomi/nabu
git clone https://gitlab.com/crdroidandroid/android_vendor_xiaomi_nabu vendor/xiaomi/nabu
git clone https://github.com/hxfuxyy/android_kernel_xiaomi_sm8150 kernel/xiaomi/nabu
rm -rf hardware/xiaomi
git clone https://github.com/Evolution-X-Devices/hardware_xiaomi hardware/xiaomi
git clone https://github.com/TogoFire/packages_apps_ViPER4AndroidFX packages/apps/ViPER4AndroidFX
rm -rf packages/apps/Updater
git clone https://github.com/hxfuxyy/packages_apps_Updater packages/apps/Updater
git clone https://github.com/hxfuxyy/inf-patches patches -b test
cd frameworks/base
git apply --verbose ../../patches/frameworks_base.patch
cd ../..
cd packages/apps/Settings
git apply --verbose ../../../patches/packages_apps_Settings.patch
cd ../../..
cd packages/apps/Updater
git apply --verbose ../../../patches/updater_vanilla.patch
cd ../../..
. build/envsetup.sh
export WITH_GAPPS=false
NPROC=$(nproc --all)
lunch infinity_nabu-userdebug && mka bacon -j${NPROC} 2>&1 | tee build.log

if [ ${PIPESTATUS[0]} -eq 0 ]; then
    OUT_DIR="out/target/product/nabu"
    
    ZIP_FILE=$(ls -t ${OUT_DIR}/*nabu*.zip 2>/dev/null | head -n1)
    if [ -f "$ZIP_FILE" ]; then
        curl -T "$ZIP_FILE" -u :257abae2-a1f3-4ab1-816e-39a94790ff0b https://pixeldrain.com/api/file/
    fi
    
    if [ -f "${OUT_DIR}/boot.img" ]; then
        curl -T "${OUT_DIR}/boot.img" -u :257abae2-a1f3-4ab1-816e-39a94790ff0b https://pixeldrain.com/api/file/
    fi
    
    if [ -f "${OUT_DIR}/dtbo.img" ]; then
        curl -T "${OUT_DIR}/dtbo.img" -u :257abae2-a1f3-4ab1-816e-39a94790ff0b https://pixeldrain.com/api/file/
    fi
    
    if [ -f "${OUT_DIR}/vendor_boot.img" ]; then
        curl -T "${OUT_DIR}/vendor_boot.img" -u :257abae2-a1f3-4ab1-816e-39a94790ff0b https://pixeldrain.com/api/file/
    fi
else
    if [ -f "build.log" ]; then
        curl -T "build.log" -u :257abae2-a1f3-4ab1-816e-39a94790ff0b https://pixeldrain.com/api/file/
    fi
    exit 1
fi
