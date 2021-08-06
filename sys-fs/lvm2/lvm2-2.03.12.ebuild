# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools linux-info toolchain-funcs flag-o-matic

DESCRIPTION="User-land utilities for LVM2 (device-mapper) software"
HOMEPAGE="https://sourceware.org/lvm2/"
SRC_URI="https://sourceware.org/pub/lvm2/LVM2.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="amd64 arm64"

IUSE="static-libs systemd +udev +dm-only"

RDEPEND="
	app-core/layout
	>=app-core/util-linux-2.16
"

DEPEND="
	lib-core/readline:0=
	systemd? ( >=app-core/systemd-205:0= )
	dev-util/pkgconf
	lib-dev/libaio
	>=sys-devel/binutils-2.20.1-r1
	sys-devel/autoconf-archive
"

S=${WORKDIR}/LVM2.${PV}

filter-flags -Wl,-z,defs

src_prepare() {
	default

	sed -i \
		-e "1iAR = $(tc-getAR)" \
		-e "s:CC ?= @CC@:CC = $(tc-getCC):" \
		make.tmpl.in || die #444082

	eautoreconf
}

src_configure() {
	local myconf=(
		--prefix="${EPREFIX}"/usr
   		--sysconfdir="${EPREFIX}"/etc
   		--localstatedir="${EPREFIX}"/var
		$(usex dm-only "" "--enable-applib")
		$(usex dm-only "" "--enable-cmdlib")
		$(usex dm-only "" "--enable-dmeventd")
		$(usex dm-only "" "--enable-lvmetad")
		$(usex dm-only "" "--enable-lvmpolld")
		$(usex dm-only "" "--enable-use-lvmetad")
   		--enable-pkgconfig
   		--enable-readline
   		--enable-udev_rules
   		--enable-udev_sync
   		--with-cache=internal
   		--with-default-dm-run-dir="${EPREFIX}"/run
   		--with-default-locking-dir="${EPREFIX}"/run/lock/lvm
   		--with-default-pid-dir="${EPREFIX}"/run
   		--with-default-run-dir="${EPREFIX}"/run/lvm
   		$(use_enable systemd udev-systemd-background-jobs)
		--with-systemdsystemunitdir=$(usex systemd "${EPREFIX}/usr/lib/systemd/system" "false")
   		--with-thin=internal
   		$(use_enable udev udev_rules)
		$(use_enable udev udev_sync)
		$(use_with udev udevdir "${EPREFIX}"/usr/lib/udev/rules.d)
	)
	econf ${myconf[@]} CLDFLAGS="${LDFLAGS}"
}

src_install() {
	local inst
	use dm-only || INSTALL_TARGETS="install_lvm2"
	use dm-only || use systemd && INSTALL_TARGETS="${INSTALL_TARGETS} install_systemd_units install_systemd_generators"
	use dm-only && INSTALL_TARGETS="install_device-mapper"

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
