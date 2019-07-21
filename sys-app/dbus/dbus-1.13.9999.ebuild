# Distributed under the terms of the GNU General Public License v2

EAPI=7


inherit git-r3 autotools linux-info flag-o-matic python-any-r1 systemd virtualx user

DESCRIPTION="A message bus system, a simple way for applications to talk to each other"
HOMEPAGE="https://dbus.freedesktop.org/"
EGIT_REPO_URI="https://gitlab.freedesktop.org/dbus/dbus.git"
#EGIT_BRANCH="dbus-1.14"

LICENSE="|| ( AFL-2.1 GPL-2 )"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="debug doc static-libs systemd test user-session X"

#RESTRICT="test"

REQUIRED_USE="
	test? ( debug )
"

CDEPEND="
	>=lib-dev/expat-2.1.0
	systemd? ( sys-app/systemd:0= )
	X? (
		x11-libs/libX11
		x11-libs/libXt
		)
"
DEPEND="${CDEPEND}
	lib-dev/expat
	sys-devel/autoconf-archive
	dev-util/pkgconf
	doc? ( app-text/doxygen )
	test? (
		>=lib-dev/glib-2.40:2
		${PYTHON_DEPS}
		)
"
RDEPEND="${CDEPEND}
"

# out of sources build dir for make check
TBD="${WORKDIR}/${P}-tests-build"

append-flags -rdynamic

pkg_setup() {
	enewgroup messagebus
	enewuser messagebus -1 -1 -1 messagebus

	use test && python-any-r1_pkg_setup

	CONFIG_CHECK="~EPOLL"
	linux-info_pkg_setup
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf

	myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
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
		--with-systemdsystemunitdir="$(systemd_get_systemunitdir)"
		--with-dbus-user=messagebus
		$(use_with X x)
		--disable-xml-docs
		--disable-doxygen-docs
		--disable-traditional-activation
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

src_test() {
	DBUS_VERBOSE=1 virtx emake -j1 -C "${TBD}" check
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

	insinto /usr/lib/tmpfiles.d/
	doins "${FILESDIR}"/dbus.conf

	insinto /usr/lib/systemd/system/
	doins "${FILESDIR}"/dbus.service
}
