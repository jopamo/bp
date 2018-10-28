# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit git-r3 autotools linux-info flag-o-matic python-any-r1 systemd virtualx user multilib-minimal

DESCRIPTION="A message bus system, a simple way for applications to talk to each other"
HOMEPAGE="https://dbus.freedesktop.org/"
#SRC_URI="https://dbus.freedesktop.org/releases/dbus/${P}.tar.gz"
EGIT_REPO_URI="https://anongit.freedesktop.org/git/dbus/dbus.git"

LICENSE="|| ( AFL-2.1 GPL-2 )"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="debug doc selinux static-libs systemd test user-session X"

#RESTRICT="test"

REQUIRED_USE="
	test? ( debug )
"

CDEPEND="
	>=lib-dev/expat-2.1.0
	selinux? ( lib-sys/libselinux )
	systemd? ( sys-app/systemd:0= )
	X? (
		x11-libs/libX11
		x11-libs/libXt
		)
"
DEPEND="${CDEPEND}
	app-text/xmlto
	app-text/docbook-xml-dtd:4.4
	lib-dev/expat
	sys-devel/autoconf-archive
	dev-util/pkgconfig
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

pkg_setup() {
	enewgroup messagebus
	enewuser messagebus -1 -1 -1 messagebus

	use test && python-any-r1_pkg_setup

	if use kernel_linux; then
		CONFIG_CHECK="~EPOLL"
		linux-info_pkg_setup
	fi
}

src_prepare() {
	# Tests were restricted because of this
	sed -i \
		-e 's/.*bus_dispatch_test.*/printf ("Disabled due to excess noise\\n");/' \
		-e '/"dispatch"/d' \
		bus/test-main.c || die

	default

	eautoreconf
}

multilib_src_configure() {
	local docconf myconf

	# so we can get backtraces from app-misc
	case ${CHOST} in
		*-mingw*)
			# error: unrecognized command line option '-rdynamic' wrt #488036
			;;
		*)
			append-flags -rdynamic
			;;
	esac

	# libaudit is *only* used in DBus wrt SELinux support, so disable it, if
	# not on an SELinux profile.
	myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable static-libs static)
		$(use_enable debug verbose-mode)
		--disable-asserts
		--disable-checks
		$(use_enable selinux)
		$(use_enable selinux libaudit)
		--disable-apparmor
		$(use_enable kernel_linux inotify)
		$(use_enable kernel_FreeBSD kqueue)
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
	)

	if [[ ${CHOST} == *-darwin* ]]; then
		myconf+=(
			--enable-launchd
			--with-launchd-agent-dir="${EPREFIX}"/Library/LaunchAgents
		)
	fi

	if multilib_is_native_abi; then
		docconf=(
			--enable-xml-docs
			$(use_enable doc doxygen-docs)
		)
	else
		docconf=(
			--disable-xml-docs
			--disable-doxygen-docs
		)
		myconf+=(
			--disable-selinux
			--disable-libaudit
			--disable-systemd
			--without-x

			# expat is used for the daemon only
			# fake the check for multilib library build
			ac_cv_lib_expat_XML_ParserCreate_MM=yes
		)
	fi

	einfo "Running configure in ${BUILD_DIR}"
	ECONF_SOURCE="${S}" econf "${myconf[@]}" "${docconf[@]}"

	if multilib_is_native_abi && use test; then
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

multilib_src_compile() {
	if multilib_is_native_abi; then
		# after the compile, it uses a selinuxfs interface to
		# check if the SELinux policy has the right support
		use selinux && addwrite /selinux/access

		einfo "Running make in ${BUILD_DIR}"
		emake

		if use test; then
			einfo "Running make in ${TBD}"
			emake -C "${TBD}"
		fi
	else
		emake -C dbus libdbus-1.la
	fi
}

src_test() {
	DBUS_VERBOSE=1 virtx emake -j1 -C "${TBD}" check
}

multilib_src_install() {
	if multilib_is_native_abi; then
		emake DESTDIR="${D}" install
	else
		emake DESTDIR="${D}" install-pkgconfigDATA
		emake DESTDIR="${D}" -C dbus \
			install-libLTLIBRARIES install-dbusincludeHEADERS \
			install-nodist_dbusarchincludeHEADERS
	fi
}

multilib_src_install_all() {
	if use X; then
		# dbus X session script (#77504)
		# turns out to only work for GDM (and startx). has been merged into
		# other desktop (kdm and such scripts)
		exeinto /etc/X11/xinit/xinitrc.d
		doexe "${FILESDIR}"/80-dbus
	fi

	# needs to exist for dbus sessions to launch
	keepdir /usr/share/dbus-1/services
	keepdir /etc/dbus-1/{session,system}.d
	# machine-id symlink from pkg_postinst()
	keepdir /var/lib/dbus
	# let the init script create the /var/run/dbus directory
	rm -rf "${ED}"/var/run
	rm -rf "${ED}"/run

	cp "${FILESDIR}"/dbus.conf "${ED}"/usr/lib/tmpfiles.d/
	find "${ED}" -name "*.la" -delete || die
}
