# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools linux-info systemd toolchain-funcs flag-o-matic

DESCRIPTION="User-land utilities for LVM2 (device-mapper) software"
HOMEPAGE="https://sourceware.org/lvm2/"
SRC_URI="https://sourceware.org/pub/lvm2/LVM2.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="readline static-libs systemd +udev +thin device-mapper-only"

REQUIRED_USE="device-mapper-only? ( !thin )
	systemd? ( udev )
"

RDEPEND="
	sys-app/layout
	>=sys-app/util-linux-2.16
	thin? ( >=sys-app/thin-provisioning-tools-0.3.0 )"

DEPEND="
	readline? ( lib-sys/readline:0= )
	systemd? ( >=sys-app/systemd-205:0= )
	dev-util/pkgconf
	lib-dev/libaio
	>=sys-devel/binutils-2.20.1-r1
	sys-devel/autoconf-archive
"

S=${WORKDIR}/${PN/lvm/LVM}.${PV}

filter-flags -flto\=\* -Wl,-z,defs -Wl,-z,relro

src_prepare() {
	default

	sed -i \
		-e "1iAR = $(tc-getAR)" \
		-e "s:CC ?= @CC@:CC = $(tc-getCC):" \
		make.tmpl.in || die #444082

	sed -i -e "s:/usr/bin/true:$(type -P true):" scripts/blk_availability_systemd_red_hat.service.in || die #517514

	# Without thin-privision-tools, there is nothing to install for target install_man7:
	use thin || { sed -i -e '/^install_lvm2/s:install_man7::' man/Makefile.in || die; }

	eautoreconf
}

src_configure() {
	local myconf=()

	myconf+=( $(use_enable !device-mapper-only dmeventd) )
	myconf+=( $(use_enable !device-mapper-only cmdlib) )
	myconf+=( $(use_enable !device-mapper-only applib) )
	myconf+=( $(use_enable !device-mapper-only fsadm) )
	myconf+=( $(use_enable !device-mapper-only lvmetad) )
	myconf+=( $(use_enable !device-mapper-only use-lvmetad) )
	myconf+=( $(use_enable !device-mapper-only lvmpolld) )
	use device-mapper-only && myconf+=( --disable-udev-systemd-background-jobs )

	if use thin; then
		myconf+=( --with-thin=internal --with-cache=internal )
		local texec
		for texec in check dump repair restore; do
			myconf+=( --with-thin-${texec}="${EPREFIX}"/usr/sbin/thin_${texec} )
			myconf+=( --with-cache-${texec}="${EPREFIX}"/usr/sbin/cache_${texec} )
		done
	else
		myconf+=( --with-thin=none --with-cache=none )
	fi

	myconf+=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--with-confdir="${EPREFIX}"/etc
		--exec-prefix="${EPREFIX}"
		--localstatedir="${EPREFIX}/var"
		$(use_enable readline)
		--enable-pkgconfig
		--with-staticdir="${EPREFIX}"/usr/sbin
		--with-usrlibdir="${EPREFIX}"/usr/lib
		--with-default-dm-run-dir=/run
		--with-default-run-dir=/run/lvm
		--with-default-locking-dir=/run/lock/lvm
		--with-default-pid-dir=/run
		$(use_enable udev udev_rules)
		$(use_enable udev udev_sync)
		$(use_with udev udevdir "${EPREFIX}"/usr/lib/udev/rules.d)
		$(use_enable systemd udev-systemd-background-jobs)
		--with-systemdsystemunitdir="$(systemd_get_systemunitdir)"
	)
	econf ${myconf[@]} CLDFLAGS="${LDFLAGS}"
}

src_install() {
	default
	local inst
	INSTALL_TARGETS="install install_tmpfiles_configuration"
	# install systemd related files only when requested, bug #522430
	use systemd && INSTALL_TARGETS="${INSTALL_TARGETS} install_systemd_units install_systemd_generators"
	for inst in ${INSTALL_TARGETS}; do
		emake DESTDIR="${D}" ${inst}
		emake DESTDIR="${D}" -C scripts lvm2_activation_generator_systemd_red_hat
	done

	if use static-libs; then
		dolib.a libdm/ioctl/libdevmapper.a
		dolib.a libdaemon/client/libdaemonclient.a #462908
		dolib.a daemons/dmeventd/libdevmapper-event.a
	else
		rm -f "${ED}"/usr/lib/{libdevmapper-event,liblvm2cmd,liblvm2app,libdevmapper}.a
	fi
}
