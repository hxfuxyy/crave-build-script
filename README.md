# build — InfinityX for Xiaomi Pad 5 (nabu)

Build script for compiling [ProjectInfinity-X](https://github.com/ProjectInfinity-X) (Android 16) on the Xiaomi Pad 5 (`nabu`) using [Crave](https://crave.io).

## Usage
Run `build.sh` inside a Crave devspace. The script will:
1. Initialize the ProjectInfinity-X manifest (Android 16)
2. Clone device, kernel, vendor and hardware trees
3. Apply patches from [patches repo](https://github.com/hxfuxyy/inf-patches)
4. Build the ROM and upload artifacts to Pixeldrain
