# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic linux-info linux-mod distutils-r1 systemd toolchain-funcs

DESCRIPTION="Userland utilities for ZFS Linux kernel module"
HOMEPAGE="https://zfsonlinux.org/"

if [[ ${PV} == "9999" ]] ; then
	inherit autotools git-r3
	EGIT_REPO_URI="https://github.com/zfsonlinux/zfs.git"
else
	SRC_URI="https://github.com/zfsonlinux/${PN}/releases/download/${P}/${P}.tar.gz"
fi

LICENSE="BSD-2 CDDL MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug python test-suite static-libs"

COMMON_DEPEND="
	${PYTHON_DEPS}
	lib-net/libtirpc
	sys-app/util-linux[static-libs?]
	lib-sys/zlib[static-libs(+)?]
	sys-app/gawk
	python? (
		dev-python/cffi[${PYTHON_USEDEP}]
	)
"

BDEPEND="${COMMON_DEPEND}
	dev-util/pkgconf
	python? (
		dev-python/setuptools[${PYTHON_USEDEP}]
	)
"

RDEPEND="${COMMON_DEPEND}
	~sys-fs/zfs-kmod-${PV}
	sys-app/systemd
	app-compression/cpio
	app-misc/pax-utils
	test-suite? (
		sys-app/util-linux
		sys-devel/bc
		sys-fs/parted
		sys-fs/lsscsi
		sys-fs/mdadm
		sys-app/procps
		sys-app/kmod
	)
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"

pkg_setup() {
	if use kernel_linux && use test-suite; then
		linux-info_pkg_setup

		if  ! linux_config_exists; then
			ewarn "Cannot check the linux kernel configuration."
		else
			if use test-suite; then
				if linux_chkconfig_present BLK_DEV_LOOP; then
					eerror "The ZFS test suite requires loop device support enabled."
					eerror "Please enable it:"
					eerror "    CONFIG_BLK_DEV_LOOP=y"
					eerror "in /usr/src/linux/.config or"
					eerror "    Device Drivers --->"
					eerror "        Block devices --->"
					eerror "            [X] Loopback device support"
				fi
			fi
		fi
	fi
}

src_prepare() {
	default

	if [[ ${PV} == "9999" ]]; then
		eautoreconf
	else
		# Set revision number
		sed -i "s/\(Release:\)\(.*\)1/\1\2${PR}/" META || die
	fi

	# Update paths
	sed -e "s|/sbin/lsmod|/bin/lsmod|" \
		-e "s|/usr/bin/scsi-rescan|/usr/sbin/rescan-scsi-bus|" \
		-e "s|/sbin/parted|/usr/sbin/parted|" \
		-i scripts/common.sh.in || die

	if use python; then
		pushd contrib/pyzfs >/dev/null || die
		distutils-r1_src_prepare
		popd >/dev/null || die
	fi
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--enable-systemd
		--enable-sysvinit
		--with-config=user
		--with-dracutdir="${EPREFIX}/usr/lib/dracut"
		--with-linux="${KV_DIR}"
		--with-linux-obj="${KV_OUT_DIR}"
		--with-udevdir="$(get_udevdir)"
		--with-systemdunitdir="$(systemd_get_systemunitdir)"
		--with-systemdpresetdir="${EPREFIX}/lib/systemd/system-preset"
		$(use_enable debug)
		$(use_enable python pyzfs)
	)

	econf "${myconf[@]}"
}

src_compile() {
	default
	if use python; then
		pushd contrib/pyzfs >/dev/null || die
		distutils-r1_src_compile
		popd >/dev/null || die
	fi
}

src_install() {
	default

	use test-suite || rm -rf "${ED}/usr/share/zfs"

	# strip executable bit from conf.d file
	fperms 0644 /etc/conf.d/zfs

	if use python; then
		pushd contrib/pyzfs >/dev/null || die
		distutils-r1_src_install
		popd >/dev/null || die
	fi

	# enforce best available python implementation
	python_setup
	python_fix_shebang "${ED}/bin"
}

pkg_postinst() {
	if [[ ${PV} = "9999" ]]; then
		einfo "Adding ${P} to the module database to ensure that the"
		einfo "kernel modules and userland utilities stay in sync."
		update_moduledb
	fi

	systemd_reenable zfs-zed.service
	systemd_reenable zfs-import-cache.service
	systemd_reenable zfs-import-scan.service
	systemd_reenable zfs-mount.service
	systemd_reenable zfs-share.service
	systemd_reenable zfs-import.target
	systemd_reenable zfs.target
}

pkg_postrm() {
	if [[ ${PV} == "9999" ]]; then
		remove_moduledb
	fi
}
