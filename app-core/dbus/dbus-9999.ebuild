# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info flag-o-matic user

DESCRIPTION="A message bus system, a simple way for applications to talk to each other"
HOMEPAGE="https://dbus.freedesktop.org/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://gitlab.freedesktop.org/${PN}/${PN}.git"
	inherit git-r3 autotools
elif [[ ${PV} == 20* ]]; then
	inherit autotools
	SNAPSHOT=71f74ee53094340118918ba384ac7165045075cf
	SRC_URI="https://gitlab.freedesktop.org/${PN}/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
else
	SRC_URI="https://dbus.freedesktop.org/releases/dbus/${P}.tar.gz"
fi

LICENSE="|| ( AFL-2.1 GPL-2 )"
SLOT="0"

IUSE="debug static-libs systemd sysusersd test tmpfilesd user-session X"

DEPEND="
	lib-core/expat
	systemd? ( app-core/systemd )
	X? (
		xgui-live-lib/libX11
		xgui-live-lib/libXt
		)
"
BDEPEND="
	app-build/autoconf-archive
	app-dev/pkgconf
"

# out of sources build dir for make check
TBD="${WORKDIR}/${P}-tests-build"

append-flags -rdynamic

pkg_setup() {
	CONFIG_CHECK="~EPOLL"
	linux-info_pkg_setup
}

src_prepare() {
	default

	if [[ ${PV} == *9999 ]] || [[ ${PV} == 20* ]] ; then
		eautoreconf
	fi
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		$(use_enable debug verbose-mode)
		--disable-asserts
		--disable-checks
		--disable-apparmor
		--enable-inotify
		$(use_enable systemd)
		$(use_enable user-session)
		--disable-embedded-tests
		--disable-modular-tests
		$(use_enable debug stats)
		--with-session-socket-dir="${EPREFIX}"/tmp
		--with-system-pid-file="${EPREFIX}"/run/dbus.pid
		--with-system-socket="${EPREFIX}"/run/dbus/system_bus_socket
		--with-systemdsystemunitdir=$(usex systemd "${EPREFIX}/usr/lib/systemd/system" "false")
		--with-dbus-user=messagebus
		$(use_with X x)
		--disable-xml-docs
		--disable-doxygen-docs
		--disable-traditional-activation
		--disable-libaudit
	)

	einfo "Running configure in ${BUILD_DIR}"
	ECONF_SOURCE="${S}" econf "${myconf[@]}"

	if use test; then
		mkdir "${TBD}" || die
		cd "${TBD}" || die
		einfo "Running configure in ${TBD}"
		ECONF_SOURCE="${S}" econf "${myconf[@]}" \
			$(use_enable test asserts) \
			$(use_enable test checks) \
			$(use_enable test embedded-tests) \
			$(has_version lib-dev/dbus-glib && echo --enable-modular-tests)
	fi
}

src_compile() {
	einfo "Running make in ${BUILD_DIR}"
	emake

	if use test; then
		einfo "Running make in ${TBD}"
		emake -C "${TBD}"
	fi
}

src_install() {
	default

	if use X; then
		# dbus X session script (#77504)
		# turns out to only work for GDM (and startx). has been merged into
		# other desktop (kdm and such scripts)
		exeinto /etc/X11/xinit/xinitrc.d
		doexe "${FILESDIR}"/80-dbus
	fi

	# needs to exist for dbus sessions to launch
	keepdir /usr/share/dbus-1/services

	# machine-id symlink from pkg_postinst()
	keepdir /var/lib/dbus

	# let the init script create the /var/run/dbus directory
	rm -rf "${ED}"/var/run
	rm -rf "${ED}"/run

	rm -rf "${ED}"/etc/dbus-1

	if use tmpfilesd; then
		insopts -m 0644
		insinto /usr/lib/tmpfiles.d
		newins "${FILESDIR}/${PN}-tmpfiles" ${PN}.conf
	fi

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/${PN}.service"
	fi
}

pkg_preinst() {
	if use sysusersd; then
		insopts -m 0644
		insinto /usr/lib/sysusers.d
		newins "${FILESDIR}/${PN}-sysusers" ${PN}.conf
	else
		rm -r "${ED}"/usr/lib/sysusers.d || die
		enewgroup messagebus
		enewuser messagebus 101 -1 -1 messagebus
	fi
}
