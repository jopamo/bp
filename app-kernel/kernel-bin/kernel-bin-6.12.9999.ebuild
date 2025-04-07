# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Linux kernel source code tree"
HOMEPAGE="https://kernel.org/"

EGIT_REPO_URI="https://gitlab.com/linux-kernel/stable"
EGIT_BRANCH="linux-$(ver_cut 1-2).y"

S="${WORKDIR}/linux-${PV}"
EGIT_CHECKOUT_DIR="${S}"

LICENSE="GPL"
SLOT="$(ver_cut 1-2)"
KEYWORDS="amd64 arm64"

IUSE="initramfs"

RESTRICT="network-sandbox sandbox usersandbox"

BDEPEND="
	app-kernel/dracut
	app-core/ed
	app-util/bc
"

src_prepare() {
	unset ARCH

	default
	cp "${FILESDIR}"/config .config
	emake olddefconfig
	emake prepare

	eapply "${FILESDIR}"/reg.patch
}

src_install() {
	emake modules_install INSTALL_MOD_PATH="${ED}/usr"
	emake install INSTALL_PATH="${ED}/boot"
	emake headers_install INSTALL_HDR_PATH="${ED}/usr"
	export KERNEL_VERSION=$(make -s kernelrelease)
}

pkg_postinst() {
	mount /boot
	mount /boot/efi

	rm /boot/initramfs-*.img

	use initramfs && dracut \
		-f "/boot/initramfs-${KERNEL_VERSION}.img" \
		"${KERNEL_VERSION}" \
		--kernel-image "/boot/vmlinuz-${KERNEL_VERSION}" \
		--early-microcode \
		--mdadmconf \
		--hostonly \
		--lvmconf \
		--strip \
		--zstd || die

	grub-install --efi-directory=/boot/efi
	grub-install --efi-directory=/boot/efi --removable
	grub-mkconfig -o /boot/grub/grub.cfg

	unset KERNEL_VERSION
}

