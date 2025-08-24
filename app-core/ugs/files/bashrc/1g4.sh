#!/bin/sh

alias eupdate='emerge --sync && eup'
alias rebuild_packages='eup && rebuild_world'
alias 1g4_nspawn='systemd-nspawn --bind /var/cache/distfiles --bind-ro /var/db/repos/bp'
alias oneshot='emerge --oneshot'
alias update_world='emerge --keep-going -uDNv world'
alias update_everything='emerge --keep-going -euDNv world'

move_package() {
	# show help when run with no args or with -h/--help
	if [[ $# -lt 2 || "$1" == "-h" || "$1" == "--help" ]]; then
		cat <<'EOF'
Usage: move_package <package-name> <new-category>

Moves a Gentoo package directory inside /var/db/repos/bp to a new category
and updates all internal repository references.

Example:
  move_package nettle lib-core
EOF
		return 1
	fi

	local REPO_PATH="/var/db/repos/bp"
	local package_name="$1"
	local new_category="$2"

	# locate package directory inside repo
	local found_path
	found_path=$(find "$REPO_PATH" -type d -name "$package_name" ! -path "*/.git/*" -print -quit)

	if [[ -z "$found_path" ]]; then
		echo "Package '$package_name' not found"
		return 1
	fi

	local old_path
	old_path=$(dirname "$found_path" | sed "s|$REPO_PATH/||")
	local new_path="$new_category"

	echo "Preparing to move '$package_name' from '$old_path' to '$new_path'"

	mkdir -p "$REPO_PATH/$new_path"

	if mv "$found_path" "$REPO_PATH/$new_path/$package_name"; then
		echo "Moved '$package_name' to '$new_path'"

		# escape paths for sed
		local old_pattern_escaped
		old_pattern_escaped=$(printf '%s\n' "$old_path/$package_name" | sed 's:[][\/.^$*]:\\&:g')
		local new_pattern_escaped
		new_pattern_escaped=$(printf '%s\n' "$new_path/$package_name" | sed 's:[][\/.^$*]:\\&:g')

		# update references across repo safely using NUL‑delimited list
		while IFS= read -r -d '' file; do
			sed -i "s|$old_pattern_escaped|$new_pattern_escaped|g" "$file"
		done < <(find "$REPO_PATH" -type f ! -path "*/.git/*" -print0)

		echo "Updated references from '$old_path/$package_name' to '$new_path/$package_name'"
	else
		echo "Failed to move '$package_name'"
		return 1
	fi
}

bootstrap_go() {
	trap 'echo "Interrupted by user"; return 1' SIGINT

	USE=go-bootstrap emerge --oneshot gcc
	FEATURES="-sandbox -usersandbox" emerge --oneshot =app-lang/go-1.21*
	emerge --oneshot =app-lang/go-1.23*
	emerge --oneshot go
}

eup() {
	trap 'echo "Interrupted by user"; return 1' SIGINT

	esync || return 1
	emerge --keep-going -uDNv world || return 1
	env-update && source /etc/profile || return 1
	emerge --depclean || return 1
	emerge @preserved-rebuild || return 1
	emerge --keep-going -uDNv world || return 1
	emerge --oneshot libtool || return 1
	env-update && source /etc/profile || return 1

	trap - SIGINT
}

esync() {
	trap 'echo "Interrupted by user"; return 1' SIGINT

	echo "Regenerating bp repo cache..."

	for dir in /var/db/repos/*/; do
		dir=${dir%*/}

		if [ -d "$dir" ]; then
			echo "Updating cache for repo: ${dir##*/}"
			pushd "$dir" > /dev/null
			egencache --jobs=8 --update --repo "${dir##*/}"
			popd > /dev/null
		else
			echo "Skipping non-directory: $dir"
		fi
	done

	emerge --regen || return 1
	emerge --metadata || return 1
	eix-update || return 1

	trap - SIGINT
}

rebuild_world() {
	rm -rf /var/cache/packages/*
	emerge --keep-going -ueDNv world
}

update_kernel_auto() {
  local rc
  (
    # ---- fail-fast only inside this subshell ----
    set -Eeuo pipefail
    shopt -s inherit_errexit 2>/dev/null || true   # Bash 4.4+: make $(...) honor -e
    trap 'rc=$?; echo "ERROR: $BASH_SOURCE:$LINENO: $BASH_COMMAND (rc=$rc)" >&2; exit $rc' ERR
    trap 'echo "Interrupted by user (SIGINT)"; exit 130' INT

    # Helper: return 0 if nvidia-drivers is installed
    detect_nvidia() {
      local atom="bin/nvidia-drivers"
      if command -v portageq &>/dev/null; then
        portageq has_version / "${atom}" &>/dev/null && return 0
        [[ -n $(portageq match / "${atom}" 2>/dev/null) ]] && return 0
      fi
      command -v equery &>/dev/null && equery -q list -i "${atom}" &>/dev/null && return 0
      command -v qlist  &>/dev/null && qlist  -IC "${atom}"        &>/dev/null && return 0
      compgen -G "/var/db/pkg/bin/nvidia-drivers-*" &>/dev/null && return 0
      return 1
    }

    # Root requirement and kernel source check
    [[ $EUID -eq 0 ]] || { echo "Must be run as root!" >&2; exit 1; }
    [[ -d /usr/src/linux ]] || { echo "/usr/src/linux not found." >&2; exit 1; }
    cd /usr/src/linux

    # Kernel configuration and preparation
    make oldconfig
    make prepare

    # Ensure /boot is mounted (use if/then so -e catches failures)
    if ! mountpoint -q /boot; then
      mount /boot
    fi

    # EFI and initramfs detection
    local EFI_MODE=0 INITRAMFS_MODE=0 NVIDIA_IN_INITRAMFS=0
    if mountpoint -q /boot/efi || [[ -d /sys/firmware/efi ]]; then
      EFI_MODE=1
      mount | grep -q '/sys/firmware/efi/efivars' || \
        mount -t efivarfs efivarfs /sys/firmware/efi/efivars 2>/dev/null || true  # optional
      if ! mountpoint -q /boot/efi; then
        mount /boot/efi
      fi
      command -v dracut &>/dev/null && INITRAMFS_MODE=1
    fi

    echo "Building kernel..."
    make -j"$(nproc)"
    local KERNEL_VERSION
    KERNEL_VERSION="$(make -s kernelrelease)"  # guard in case command-subst fails
    [[ -n "${KERNEL_VERSION}" ]] || { echo "Could not determine kernel release." >&2; exit 1; }

    [[ -f arch/x86/boot/bzImage || -f vmlinux ]] || {
      echo "Build failed—no kernel image." >&2
      exit 1
    }

    # Clean out any stale targets
    [[ -d "/lib/modules/${KERNEL_VERSION}" ]] && rm -rf "/lib/modules/${KERNEL_VERSION}"
    rm -f /boot/System.map-* /boot/config-* /boot/vmlinuz-* /boot/initramfs-*

    make modules_install
    make install

    # Rebuild nvidia-drivers if installed
    if detect_nvidia; then
      echo "bin/nvidia-drivers found – rebuilding..."
      emerge --quiet-build --oneshot bin/nvidia-drivers
      NVIDIA_IN_INITRAMFS=1
    fi

    # Initramfs generation (EFI + dracut)
    if (( EFI_MODE && INITRAMFS_MODE )); then
      echo "Generating initramfs with dracut..."
      local DRACUT_OPTS=(
        -f "/boot/initramfs-${KERNEL_VERSION}.img"
        "${KERNEL_VERSION}"
        --kernel-image "/boot/vmlinuz-${KERNEL_VERSION}"
        --hostonly --early-microcode --mdadmconf --lvmconf
        --strip --zstd --logfile /var/log/dracut.log --stdlog 3
      )
      (( NVIDIA_IN_INITRAMFS )) && \
        DRACUT_OPTS+=( --add-drivers "nvidia nvidia_modeset nvidia_drm nvidia_uvm" )
      dracut "${DRACUT_OPTS[@]}"
    fi

    echo "Updating bootloader..."
    if (( EFI_MODE )); then
      mkdir -p /boot/grub
      grub-mkconfig -o /boot/grub/grub.cfg
      grub-install --efi-directory=/boot/efi
      grub-install --efi-directory=/boot/efi --removable
    else
      grub-mkconfig -o /boot/grub/grub.cfg
      local BOOT_DISK
      BOOT_DISK="$(lsblk -dno NAME,TYPE | awk '$2=="disk"{print "/dev/"$1; exit}')"
      [[ -n "${BOOT_DISK:-}" ]] || { echo "Could not determine boot disk for BIOS grub-install." >&2; exit 1; }
      grub-install --target=i386-pc "${BOOT_DISK}"
    fi

    echo "Kernel update complete."
  )
  rc=$?
  if (( rc != 0 )); then
    echo "update_kernel_auto: aborted (rc=$rc)" >&2
  fi
  return "$rc"
}

update_kernel_opi5plus() {
	trap 'echo "Interrupted by user"; return 1' SIGINT
	(
		set -e

		cd /usr/src/linux
		make oldconfig
		mount /boot
		make prepare
		make -j"$(nproc)" Image
		make -j"$(nproc)" dtbs
		make -j"$(nproc)" modules

		rm -rf /lib/modules/*
		rm /boot/{System.map,config,vmlinux,vmlinuz,initrd,uInitrd}*
		rm -rf /boot/dtb*
		mkdir -p /boot/dtb/rockchip
		cp arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dtb /boot/dtb/rockchip/
		make -j"$(nproc)" Image.gz
		cp /usr/src/linux/arch/arm64/boot/Image.gz /boot/
		make modules_install

		echo "Kernel update complete."
	) || return 1
	trap - SIGINT
}

bootstrap_rust() {
	echo "Starting Rust version emerge process..."

	trap "echo 'Emerge process interrupted. Exiting...'; exit 1" SIGINT

	available_versions=$(echo "$rust_info" | grep -oP '\d+\.\d+\.\d+' | sort -V | uniq)
	installed_version=$(echo "$rust_info" | grep -Po '(?<=Installed versions:)\s*\d+\.\d+\.\d+' | head -n 1 | xargs)

	if [ -z "$installed_version" ]; then
		echo "No installed version of Rust detected."
		start_emerging=true
	else
		echo "Installed version of Rust (detected): $installed_version"
		start_emerging=false
	fi
	echo "------------------------------"

	for version in $available_versions; do
		echo "Processing version: $version"

		if [ "$version" == "$installed_version" ]; then
			echo "Installed version detected: $version. Setting flag to start emerging from next version."
			start_emerging=true
		elif [ "$start_emerging" = true ]; then
			echo "Emerging Rust version: $version"
			emerge -v =app-lang/rust-$version
			emerge_status=$?

			if [ $emerge_status -ne 0 ]; then
				echo "Error: Emerge failed for version $version. Stopping the process."
				exit 1
			fi
		else
			echo "Skipping version: $version (Already installed or earlier than installed version)"
		fi
	done

	echo "Emerge process complete."

	trap - SIGINT
}

check_bin_sbin_commands() {
	for cmd in /bin/*; do
		[ -x "/sbin/$(basename "$cmd")" ] && echo "$(basename "$cmd") exists in both /bin and /sbin"
	done
}
