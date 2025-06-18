# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info toolchain-funcs

DESCRIPTION="Generic initramfs generation tool"
HOMEPAGE="https://dracut.wiki.kernel.org"
SNAPSHOT=348888b8d9067a9e983650129b7a3ea64fb8430f
SRC_URI="https://github.com/dracut-ng/dracut-ng/archive/${SNAPSHOT}.tar.gz -> dracut-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/dracut-ng-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug systemd"

RESTRICT="test"

CDEPEND="
	virtual/service-manager
	app-dev/pkgconf
	>=app-core/kmod-15[tools]
"

RDEPEND="${CDEPEND}
	app-compression/cpio
	>=app-core/bash-4.0:0
	app-core/coreutils[xattr(-)]
	>=app-core/util-linux-2.21

	debug? ( app-dev/strace )
	!app-net/arping
"
DEPEND="${CDEPEND}
	>=lib-core/libxslt-1.1.26
	app-tex/docbook-xml-dtd
	>=app-tex/docbook-xsl-stylesheets-1.75.2
"

src_configure() {
	local myconf=(
		--prefix="${EPREFIX}/usr"
		--sysconfdir="${EPREFIX}/etc"
		--systemdsystemunitdir=$(usex systemd "${EPREFIX}/usr/lib/systemd/system" "false")
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
