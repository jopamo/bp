#!/bin/sh

alias eupdate='emerge --sync && eup'
alias rebuild_packages='eup && rebuild_world'
alias 1g4_nspawn='systemd-nspawn --bind /var/cache/distfiles --bind-ro /var/db/repos/bp --tmpfs /var/tmp/portage'
alias oneshot='emerge --oneshot'
alias update_world='emerge --keep-going -uDNv world'
alias update_everything='emerge --keep-going -euDNv world'

move_package() {
	local REPO_PATH="/var/db/repos/bp"
	local package_name="$1"
	local new_category="$2"

	local found_path=$(find "$REPO_PATH" -type d -name "$package_name" ! -path "*/.git/*" -print -quit)

	if [[ -z "$found_path" ]]; then
		echo "Package '$package_name' not found."
		return 1
	fi

	local old_path=$(dirname "$found_path" | sed "s|$REPO_PATH/||")
	local new_path="$new_category"

	echo "Preparing to move '$package_name' from '$old_path' to '$new_path'."

	mkdir -p "$REPO_PATH/$new_path"
	if mv "$found_path" "$REPO_PATH/$new_path/$package_name"; then
		echo "Moved '$package_name' to '$new_path'."

		local old_pattern_escaped=$(printf '%s\n' "$old_path/$package_name" | sed 's:[][\/.^$*]:\\&:g')
		local new_pattern_escaped=$(printf '%s\n' "$new_path/$package_name" | sed 's:[][\/.^$*]:\\&:g')

		local files_to_update=$(find "$REPO_PATH" -type f ! -path "*/.git/*")

		for file in $files_to_update; do
			sed -i "s|$old_pattern_escaped|$new_pattern_escaped|g" "$file"
		done

		echo "Updated references from '$old_path/$package_name' to '$new_path/$package_name'."
	else
		echo "Failed to move '$package_name'."
		return 1
	fi
}

bootstrap_go() {
	trap 'echo "Interrupted by user"; return 1' SIGINT

	USE=go-bootstrap emerge --oneshot gcc
	FEATURES="-sandbox -usersandbox" emerge --oneshot =app-lang/go-1.21*
	emerge --oneshot gcc
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

update_kernel_efi() {
	trap 'echo "Interrupted by user"; return 1' SIGINT
	(
		set -e

		cd /usr/src/linux
		make oldconfig
		mount -o remount,rw -t efivarfs efivarfs /sys/firmware/efi/efivars
		mount /boot
		mount /boot/efi
		make prepare

		make -j"$(nproc)"

		rm -rf /lib/modules/*
		rm /boot/System.map* /boot/config* /boot/vmlinuz*

		make modules_install
		make install

		KERNEL_VERSION=$(make -s kernelrelease)

		dracut \
			-f "/boot/initramfs-${KERNEL_VERSION}.img" \
			"${KERNEL_VERSION}" \
			--kernel-image "/boot/vmlinuz-${KERNEL_VERSION}" \
			--hostonly \
			--early-microcode \
			--mdadmconf \
			--lvmconf \
			--strip \
			--zstd \
			--logfile /var/log/dracut.log \
			--stdlog 3

		mkdir -p /boot/grub/
		grub-mkconfig -o /boot/grub/grub.cfg
		grub-install --efi-directory=/boot/efi
		grub-install --efi-directory=/boot/efi --removable

		echo "Kernel update complete."
	) || return 1
	trap - SIGINT
}

update_kernel_mbr() {
	trap 'echo "Interrupted by user"; return 1' SIGINT
	(
		set -e

		cd /usr/src/linux
		make oldconfig
		mount /boot
		make prepare
		make -j"$(nproc)"

		rm -rf /lib/modules/*
		rm /boot/System.map* /boot/config* /boot/vmlinuz*

		make modules_install
		make install

		KERNEL_VERSION=$(make -s kernelrelease)

		dracut \
			-f "/boot/initramfs-${KERNEL_VERSION}.img" \
			"${KERNEL_VERSION}" \
			--kernel-image "/boot/vmlinuz-${KERNEL_VERSION}" \
			--hostonly \
			--early-microcode \
			--mdadmconf \
			--lvmconf \
			--strip \
			--zstd \
			--logfile /var/log/dracut.log \
			--stdlog 3

		grub-mkconfig -o /boot/grub/grub.cfg
		grub-install --target=i386-pc /dev/sda

		echo "Kernel update complete."
	) || return 1
	trap - SIGINT
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
