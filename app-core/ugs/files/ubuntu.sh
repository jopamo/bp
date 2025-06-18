#!/bin/bash

install_kernel() {
	local VER="$1"
	if [[ -z $VER ]]; then
		echo "Usage: install_kernel <version>" >&2
		return 1
	fi

	local TAG="v$VER"
	local JOBS=$(nproc)
	local CWD=$(pwd)
	local SRCDIR="$CWD/linux-src-$VER"
	local LOCAL="-g"

	sudo apt update
	sudo apt install -y git build-essential bc bison flex fakeroot \
		libncurses-dev libssl-dev libelf-dev dwarves

	if [[ ! -d $SRCDIR ]]; then
		git clone --depth 1 --branch "$TAG" \
			https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git \
			"$SRCDIR"
	else
		cd "$SRCDIR"
		git fetch --depth 1 origin "$TAG"
		git checkout --force "$TAG"
	fi
	cd "$SRCDIR"

	cp /boot/config-$(uname -r) .config
	scripts/config --set-str LOCALVERSION "$LOCAL"
	yes "" | make olddefconfig

	make -j"$JOBS" bindeb-pkg

	cd ..
	sudo dpkg -i \
		linux-image-"$VER$LOCAL"_*.deb \
		linux-image-"$VER$LOCAL"-dbg_*.deb \
		linux-headers-"$VER$LOCAL"_*.deb \
		linux-libc-dev_"$VER"-*.deb

	echo "✅  Kernel $VER installed from $SRCDIR. Reboot to load it."
}
