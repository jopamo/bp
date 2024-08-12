# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="User-land utilities for LVM2 (device-mapper) software"
HOMEPAGE="https://sourceware.org/lvm2/"
SRC_URI="https://sourceware.org/pub/lvm2/LVM2.${PV}.tgz
		https://mirrors.kernel.org/sourceware/lvm2/LVM2.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs systemd +udev +dm-only"

DEPEND="
	app-core/util-linux
	lib-core/readline
	lib-dev/libaio[static-libs?]
	systemd? ( app-core/systemd )
"

S=${WORKDIR}/LVM2.${PV}

PATCHES=(
	"${FILESDIR}"/fix-stdio-usage.patch
)

src_configure() {
	local myconf=(
		--prefix="${EPREFIX}"/usr
   		--sysconfdir="${EPREFIX}"/etc
   		--localstatedir="${EPREFIX}"/var
		$(use_with udev udevdir "${EPREFIX}"/usr/lib/udev/rules.d)
		$(usex dm-only "" "--enable-applib")
		$(usex dm-only "" "--enable-cmdlib")
		$(usex dm-only "" "--enable-dmeventd")
		$(usex dm-only "" "--enable-lvmetad")
		$(usex dm-only "" "--enable-lvmpolld")
		$(usex dm-only "" "--enable-use-lvmetad")
		--with-systemdsystemunitdir=$(usex systemd "${EPREFIX}/usr/lib/systemd/system" "false")
   		$(use_enable udev udev_rules)
   		$(use_enable udev udev_sync)
   		--enable-pkgconfig
   		--enable-readline
   		--with-cache=internal
   		--with-default-dm-run-dir="${EPREFIX}"/run
   		--with-default-locking-dir="${EPREFIX}"/run/lock/lvm
   		--with-default-pid-dir="${EPREFIX}"/run
   		--with-default-run-dir="${EPREFIX}"/run/lvm
   		--with-thin=internal
	)
	econf ${myconf[@]} CLDFLAGS="${LDFLAGS}"
}

src_install() {
	use dm-only || INSTALL_TARGETS="install_lvm2"
	use dm-only || use systemd && INSTALL_TARGETS="${INSTALL_TARGETS} install_systemd_units install_systemd_generators"
	use dm-only && INSTALL_TARGETS="install_device-mapper"

	local inst
	for inst in ${INSTALL_TARGETS}; do
		emake DESTDIR="${D}" ${inst}
	done

	if use static-libs; then
		dolib.a libdm/ioctl/libdevmapper.a
		dolib.a libdaemon/client/libdaemonclient.a #462908
		dolib.a daemons/dmeventd/libdevmapper-event.a
	else
		rm -f "${ED}"/usr/lib/{libdevmapper-event,liblvm2cmd,liblvm2app,libdevmapper}.a
	fi

	use dm-only && rm -f "${ED}/usr/lib/systemd/system/"{blk-availability.service,lvm2-*}
}
