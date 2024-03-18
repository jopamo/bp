# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info flag-o-matic user meson

DESCRIPTION="A message bus system, a simple way for applications to talk to each other"
HOMEPAGE="https://dbus.freedesktop.org/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://gitlab.freedesktop.org/${PN}/${PN}.git"
	inherit git-r3
else
	SNAPSHOT=6c31c381e29c7e8e340fb7ee2fd50e04008ad230
	SRC_URI="https://gitlab.freedesktop.org/${PN}/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="|| ( AFL-2.1 GPL-2 )"
SLOT="0"

IUSE="debug inotify static-libs systemd sysusersd test +tools tmpfilesd user-session valgrind X"

DEPEND="
	lib-core/expat
	valgrind? ( app-dev/valgrind )
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

src_configure() {
	local rundir="/run"

	local emesonargs=(
		--localstatedir="${EPREFIX}/var"
		-Druntime_dir="${EPREFIX}${rundir}"

		-Ddefault_library=$(usex static-libs both shared)

		-Dapparmor=disabled
		-Dasserts=false # TODO
		-Dchecks=false # TODO
		$(meson_use debug stats)
		$(meson_use debug verbose_mode)
		-Dcontainers=false
		-Ddbus_user=messagebus
		-Dkqueue=disabled
		$(meson_feature inotify)
		-D xml_docs=enabled
		-Dembedded_tests=false
		-Dinstalled_tests=false
		-D message_bus=true
		$(meson_feature test modular_tests)
		-Dqt_help=disabled

		$(meson_use tools)

		$(meson_feature systemd)
		$(meson_use systemd user_session)
		$(meson_feature X x11_autolaunch)
		$(meson_feature valgrind)

		-D selinux=disabled
		-D libaudit=disabled

		-Dsession_socket_dir="${EPREFIX}"/tmp
		-Dsystem_pid_file="${EPREFIX}${rundir}"/dbus.pid
		-Dsystem_socket="${EPREFIX}${rundir}"/dbus/system_bus_socket
		-Dsystemd_system_unitdir=$(usex systemd "${EPREFIX}/usr/lib/systemd/system" "false")
		-Dsystemd_user_unitdir=$(usex systemd "${EPREFIX}/usr/lib/systemd/user" "false")
	)

	meson_src_configure
}

src_install() {
	meson_src_install

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
