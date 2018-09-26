# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils linux-info toolchain-funcs systemd

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dracutdevs/dracut"
else
	[[ "${PV}" = *_rc* ]] || \
	KEYWORDS="amd64 arm64 x86"
	SRC_URI="mirror://kernel/linux/utils/boot/${PN}/${P}.tar.xz"
fi

DESCRIPTION="Generic initramfs generation tool"
HOMEPAGE="https://dracut.wiki.kernel.org"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"
KEYWORDS="amd64 arm64 x86"
RESTRICT="test"

CDEPEND="sys-app/systemd
	dev-util/pkgconfig
	>=sys-app/kmod-15[tools]
	"
RDEPEND="${CDEPEND}
	app-compression/cpio
	>=sys-app/bash-4.0:0
	sys-app/coreutils[xattr(-)]
	>=sys-app/util-linux-2.21

	debug? ( dev-util/strace )
	!app-net/arping
	"
DEPEND="${CDEPEND}
	>=lib-dev/libxslt-1.1.26
	app-text/docbook-xml-dtd:4.5
	>=app-text/docbook-xsl-stylesheets-1.75.2
	"

QA_MULTILIB_PATHS="usr/lib/dracut/.*"

src_configure() {
	local myconf=(
		--prefix="${EPREFIX}/usr"
		--sysconfdir="${EPREFIX}/etc"
		--systemdsystemunitdir="$(systemd_get_systemunitdir)"
		--disable-documentation
	)

	tc-export CC PKG_CONFIG

	echo ./configure "${myconf[@]}"
	./configure "${myconf[@]}" || die
}

src_install() {
	default

	local dracutlibdir="usr/$(get_libdir)/dracut"
	local libdirs="usr/$(get_libdir)"

	echo "libdirs=\"${libdirs}\"" > "${T}/gentoo.conf"
	insinto "${dracutlibdir}/dracut.conf.d"
	doins "${T}/gentoo.conf"

	dodir /var/lib/dracut/overlay
	keepdir /var/lib/dracut/overlay
}

pkg_postinst() {
	if linux-info_get_any_version && linux_config_exists; then
		ewarn ""
		ewarn "If the following test report contains a missing kernel"
		ewarn "configuration option, you should reconfigure and rebuild your"
		ewarn "kernel before booting image generated with this Dracut version."
		ewarn ""

		local CONFIG_CHECK="~BLK_DEV_INITRD ~DEVTMPFS"

		# Kernel configuration options descriptions:
		local desc_DEVTMPFS="Maintain a devtmpfs filesystem to mount at /dev"
		local desc_BLK_DEV_INITRD="Initial RAM filesystem and RAM disk (initramfs/initrd) support"

		local opt desc

		# Generate ERROR_* variables for check_extra_config.
		for opt in ${CONFIG_CHECK}; do
			opt=${opt#\~}
			desc=desc_${opt}
			eval "local ERROR_${opt}='CONFIG_${opt}: \"${!desc}\"" \
				"is missing and REQUIRED'"
		done

		check_extra_config
		echo
	else
		ewarn ""
		ewarn "Your kernel configuration couldn't be checked.  Do you have"
		ewarn "/usr/src/linux/.config file there?  Please check manually if"
		ewarn "following options are enabled:"
		ewarn ""
		ewarn "  CONFIG_BLK_DEV_INITRD"
		ewarn "  CONFIG_DEVTMPFS"
		ewarn ""
	fi

	elog "To get additional features, a number of optional runtime"
	elog "dependencies may be installed:"
	elog ""
	optfeature "Networking support"  app-net/curl "app-net/dhcp[client]" \
		sys-app/iproute2 "app-net/iputils[arping]"
	optfeature \
		"Measure performance of the boot process for later visualisation" \
		app-benchmarks/bootchart2 sys-app/killproc sys-app/acct
	optfeature "Scan for Btrfs on block devices"  sys-fs/btrfs-progs
	optfeature "Load kernel modules and drop this privilege for real init" \
		lib-sys/libcap
	optfeature "Support CIFS" sys-app/cifs-utils
	optfeature "Decrypt devices encrypted with cryptsetup/LUKS" \
		"sys-fs/cryptsetup[-static-libs]"
	optfeature "Support for GPG-encrypted keys for crypt module" \
		app-crypt/gnupg
	optfeature \
		"Allows use of dash instead of default bash (on your own risk)" \
		sys-app/dash
	optfeature "Framebuffer splash (app-media/splashutils)" \
		app-media/splashutils
	optfeature "Support iSCSI" sys-app/open-iscsi
	optfeature "Support Logical Volume Manager" sys-fs/lvm2
	optfeature "Support MD devices, also known as software RAID devices" \
		sys-fs/mdadm
	optfeature "Support Device Mapper multipathing" sys-fs/multipath-tools
	optfeature "Plymouth boot splash"  '>=sys-app/plymouth-0.8.5-r5'
	optfeature "Support network block devices" sys-app/nbd
	optfeature "Support NFS" sys-app/nfs-utils net-nds/rpcbind
	optfeature \
		"Install ssh and scp along with config files and specified keys" \
		app-net/openssh
	optfeature "Enable logging with syslog-ng or rsyslog" sys-app/syslog-ng \
		sys-app/rsyslog
}
