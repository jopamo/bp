# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="User-land utilities for LVM2 (device-mapper) software"
HOMEPAGE="https://sourceware.org/lvm2/"
SNAPSHOT=8784b7f64b7ae3c00712f274ae01b99ad6a6d992
SRC_URI="https://github.com/1g4-mirror/lvm2/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs systemd udev dm-only"

DEPEND="
	app-core/util-linux
	lib-core/readline
	lib-dev/libaio[static-libs?]
	systemd? ( app-core/systemd )
"

PATCHES=(
	"${FILESDIR}"/fix-stdio-usage.patch
)

src_configure() {
	filter-flags -Wl,-z,defs

	local myconf=(
		--prefix="${EPREFIX}"/usr
   		--sysconfdir="${EPREFIX}"/etc
   		--localstatedir="${EPREFIX}"/var
		$(use_with udev udevdir "${EPREFIX}"/usr/lib/udev/rules.d)
		$(usex dm-only "" "--enable-cmdlib")
		$(usex dm-only "" "--enable-dmeventd")
		$(usex dm-only "" "--enable-lvmpolld")
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
	use dm-only || INSTALL_TARGETS="install_lvm2 install_device-mapper"
	use dm-only || use systemd && INSTALL_TARGETS="${INSTALL_TARGETS} install_systemd_units install_systemd_generators"
	use dm-only && INSTALL_TARGETS="install_device-mapper"

	local inst
	for inst in ${INSTALL_TARGETS}; do
		emake DESTDIR="${D}" ${inst}
	done

	#dolib.a device_mapper/libdevice-mapper.a
	#dolib.a libdaemon/client/libdaemonclient.a
	#dolib.a libdaemon/server/libdaemonserver.a

	use dm-only && rm -f "${ED}/usr/lib/systemd/system/"{blk-availability.service,lvm2-*}
}
