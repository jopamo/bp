# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools eutils linux-info systemd toolchain-funcs flag-o-matic

DESCRIPTION="User-land utilities for LVM2 (device-mapper) software"
HOMEPAGE="https://sourceware.org/lvm2/"
SRC_URI="https://sourceware.org/pub/lvm2/LVM2.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="readline static static-libs systemd clvm cman corosync lvm2create_initrd openais sanlock +udev +thin device-mapper-only"

REQUIRED_USE="device-mapper-only? ( !clvm !cman !corosync !lvm2create_initrd !openais !sanlock !thin )
	systemd? ( udev )
	clvm? ( !systemd )"

DEPEND_COMMON="
	clvm? (
		cman? ( =sys-cluster/cman-3* )
		corosync? ( sys-cluster/corosync )
		openais? ( sys-cluster/openais )
		=sys-cluster/libdlm-3*
	)

	readline? ( lib-sys/readline:0= )
	sanlock? ( sys-cluster/sanlock )
	systemd? ( >=sys-app/systemd-205:0= )
"

RDEPEND="${DEPEND_COMMON}
	sys-app/layout
	!<sys-fs/cryptsetup-1.1.2
	!!sys-fs/clvm
	!!sys-fs/lvm-user
	>=sys-app/util-linux-2.16
	lvm2create_initrd? ( sys-app/makedev )
	thin? ( >=sys-app/thin-provisioning-tools-0.3.0 )"
# note: thin- 0.3.0 is required to avoid --disable-thin_check_needs_check
# USE 'static' currently only works with eudev, bug 520450
DEPEND="${DEPEND_COMMON}
	dev-util/pkgconf
	lib-dev/libaio
	>=sys-devel/binutils-2.20.1-r1
	sys-devel/autoconf-archive
	static? (
		udev? ( >=sys-fs/eudev-3.1.2[static-libs] )
		>=sys-app/util-linux-2.16[static-libs]
	)"

S=${WORKDIR}/${PN/lvm/LVM}.${PV}

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

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
	local buildmode

	myconf+=( $(use_enable !device-mapper-only dmeventd) )
	myconf+=( $(use_enable !device-mapper-only cmdlib) )
	myconf+=( $(use_enable !device-mapper-only applib) )
	myconf+=( $(use_enable !device-mapper-only fsadm) )
	myconf+=( $(use_enable !device-mapper-only lvmetad) )
	use device-mapper-only && myconf+=( --disable-udev-systemd-background-jobs )

	# Most of this package does weird stuff.
	# The build options are tristate, and --without is NOT supported
	# options: 'none', 'internal', 'shared'
	if use static; then
		buildmode="internal"
		# This only causes the .static versions to become available
		myconf+=( --enable-static_link )
	else
		buildmode="shared"
	fi
	dmbuildmode=$(use !device-mapper-only && echo internal || echo none)

	# dmeventd requires mirrors to be internal, and snapshot available
	# so we cannot disable them
	myconf+=( --with-mirrors=${dmbuildmode} )
	myconf+=( --with-snapshots=${dmbuildmode} )
	if use thin; then
		myconf+=( --with-thin=internal --with-cache=internal )
		local texec
		for texec in check dump repair restore; do
			myconf+=( --with-thin-${texec}="${EPREFIX}"/sbin/thin_${texec} )
			myconf+=( --with-cache-${texec}="${EPREFIX}"/sbin/cache_${texec} )
		done
	else
		myconf+=( --with-thin=none --with-cache=none )
	fi

	if use clvm; then
		myconf+=( --with-cluster=${buildmode} )
		local clvmd=""
		use cman && clvmd="cman"
		#clvmd="${clvmd/cmangulm/all}"
		use corosync && clvmd="${clvmd:+$clvmd,}corosync"
		use openais && clvmd="${clvmd:+$clvmd,}openais"
		[ -z "${clvmd}" ] && clvmd="none"
		myconf+=( --with-clvmd=${clvmd} )
		myconf+=( --with-pool=${buildmode} )
		myconf+=( --enable-lvmlockd-dlm )
	else
		myconf+=( --with-clvmd=none --with-cluster=none )
	fi

	myconf+=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--with-confdir="${EPREFIX}"/etc
		--exec-prefix="${EPREFIX}"
		--localstatedir="${EPREFIX}/var"
		$(use_enable readline)
		--enable-pkgconfig
		--with-staticdir="${EPREFIX}"/usr/sbin
		--with-usrlibdir="${EPREFIX}"/usr/lib64
		--with-default-dm-run-dir=/run
		--with-default-run-dir=/run/lvm
		--with-default-locking-dir=/run/lock/lvm
		--with-default-pid-dir=/run
		$(use_enable udev udev_rules)
		$(use_enable udev udev_sync)
		$(use_with udev udevdir "$(get_udevdir)"/rules.d)
		$(use_enable sanlock lvmlockd-sanlock)
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
		rm -f "${ED}"usr/lib64/{libdevmapper-event,liblvm2cmd,liblvm2app,libdevmapper}.a
	fi

	if use lvm2create_initrd; then
		dosbin scripts/lvm2create_initrd/lvm2create_initrd
		doman scripts/lvm2create_initrd/lvm2create_initrd.8
		newdoc scripts/lvm2create_initrd/README README.lvm2create_initrd
	fi
}
