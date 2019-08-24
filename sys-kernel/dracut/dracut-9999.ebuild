# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info toolchain-funcs systemd

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dracutdevs/dracut"
else
	[[ "${PV}" = *_rc* ]] || \
	KEYWORDS="amd64 arm64"
	SRC_URI="mirror://kernel/linux/utils/boot/${PN}/${P}.tar.xz"
fi

DESCRIPTION="Generic initramfs generation tool"
HOMEPAGE="https://dracut.wiki.kernel.org"

LICENSE="GPL-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="debug"

RESTRICT="test"

CDEPEND="
	virtual/service-manager
	dev-util/pkgconf
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

	local dracutlibdir="usr/lib/dracut"
	local libdirs="usr/lib"

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
}
