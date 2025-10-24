# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="linux-$(ver_cut 1-2).y"
SNAPSHOT=4afb9d6bd4c4b3dad7e2c9c48b6c8a55275d8f46

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
ETYPE="sources"

inherit kernel-2

DESCRIPTION="Prebuilt Linux kernel and supporting files"
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

    local kverdir="${ED}/usr/src/linux-${PV}"
    mkdir -p "${kverdir}"

    # Required for out-of-tree module builds
    cp -a "${S}/Makefile" "${kverdir}/"
    cp -a "${S}/.config" "${kverdir}/"
    cp -a "${S}/Module.symvers" "${kverdir}/" 2>/dev/null || true
    cp -a "${S}/Kconfig" "${kverdir}/" 2>/dev/null || true

    cp -a "${S}/include" "${kverdir}/"
    cp -a "${S}/arch/$(uname -m)/include" "${kverdir}/arch/$(uname -m)/"
    cp -a "${S}/scripts" "${kverdir}/"
    cp -a "${S}/tools" "${kverdir}/" 2>/dev/null || true

    # Generated headers and version info
    if [ -d "${S}/include/generated" ]; then
        cp -a "${S}/include/generated" "${kverdir}/include/"
    fi
    if [ -f "${S}/include/generated/uapi/linux/version.h" ]; then
        mkdir -p "${kverdir}/include/generated/uapi/linux/"
        cp -a "${S}/include/generated/uapi/linux/version.h" "${kverdir}/include/generated/uapi/linux/"
    fi

    case "$(uname -m)" in
        x86_64|x86)
            cp -a "${S}/arch/x86_64" "${kverdir}/arch/"
            cp -a "${S}/arch/x86" "${kverdir}/arch/"
            ;;
        arm64|aarch64)
            cp -a "${S}/arch/arm64" "${kverdir}/arch/"
            ;;
        *)
            cp -a "${S}/arch/$(uname -m)" "${kverdir}/arch/" 2>/dev/null || true
            ;;
    esac

    dosym -r /usr/src/linux-${PV} /usr/src/linux
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
