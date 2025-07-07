# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="linux-$(ver_cut 1-2).y"
SNAPSHOT=e60eb441596d1c70e4a264d2bac726c6cd2da067

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
ETYPE="sources"

inherit kernel-2

DESCRIPTION="Linux kernel source code tree"
HOMEPAGE="https://kernel.org/"
SRC_URI="https://gitlab.com/linux-kernel/stable/-/archive/${SNAPSHOT}/stable-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/stable-${SNAPSHOT}"

LICENSE="GPL"
SLOT="$(ver_cut 1-2)"
KEYWORDS="amd64 arm64"

IUSE="desktop"

BDEPEND="
	app-kernel/dracut
	app-core/ed
	app-util/bc
"
DEPEND="app-kernel/linux-headers"

src_prepare() {
	unset ARCH

	default

	cp "${FILESDIR}"/server .config
	use desktop && cp "${FILESDIR}"/desktop .config

	emake prepare
	emake

	eapply "${FILESDIR}"/reg.patch
}

src_install() {
    emake modules_install INSTALL_MOD_PATH="${ED}/usr"
    emake install INSTALL_PATH="${ED}/boot"

    export KERNEL_VERSION=$(make -s kernelrelease)

    rm -f /usr/lib/modules/"${KERNEL_VERSION}"/build
    dosym -r /usr/src/linux /usr/lib/modules/"${KERNEL_VERSION}"/build
}

pkg_preinst() {
    mountpoint -q /boot    || mount /boot
	mountpoint -q /boot/efi || mount /boot/efi

    einfo "Removing old kernels and initramfs files from /boot..."
    rm -f /boot/vmlinuz-* /boot/initramfs-*.img /boot/System.map-* /boot/config-* 2>/dev/null || true
}

pkg_postinst() {
    # Find the new kernel version(s) installed
    local kver
    kver=$(basename /boot/vmlinuz-* | head -n1 | sed 's/vmlinuz-//')

    einfo "Generating new initramfs for $kver"
    dracut -f "/boot/initramfs-${kver}.img" "$kver" \
        --kernel-image "/boot/vmlinuz-${kver}" \
        --early-microcode --mdadmconf --hostonly --lvmconf --strip --zstd || die "dracut failed"

    # Update grub config if present (auto)
    if type grub-mkconfig &>/dev/null && [[ -d /boot/grub ]]; then
        einfo "Regenerating /boot/grub/grub.cfg"
        grub-mkconfig -o /boot/grub/grub.cfg || ewarn "grub-mkconfig failed"
    fi

    if mountpoint -q /boot/efi && type grub-install &>/dev/null; then
        einfo "Updating EFI bootloader"
        grub-install --efi-directory=/boot/efi || ewarn "grub-install failed"
    fi
}
