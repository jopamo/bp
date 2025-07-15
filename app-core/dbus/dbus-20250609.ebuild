# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info flag-o-matic meson doins

DESCRIPTION="A message bus system, a simple way for applications to talk to each other"
HOMEPAGE="https://dbus.freedesktop.org/"

SNAPSHOT=37afc6128bdd518b4f14e21e7dd5ceaa69069a3b
SRC_URI="https://gitlab.freedesktop.org/dbus/dbus/-/archive/${SNAPSHOT}/dbus-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/dbus-${SNAPSHOT}

LICENSE="|| ( AFL-2.1 GPL-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="apparmor debug inotify static-libs systemd test tools tmpfilesd user-session valgrind X"

DEPEND="
	lib-core/expat
	apparmor? ( app-core/apparmor )
	valgrind? ( app-dev/valgrind )
	systemd? ( app-core/systemd )
	X? (
		xgui-lib/libX11
		xgui-lib/libXt
		)
"
BDEPEND="
	app-build/autoconf-archive
	app-dev/pkgconf
"

# out of sources build dir for make check
TBD="${WORKDIR}/${P}-tests-build"

pkg_setup() {
	CONFIG_CHECK="~EPOLL"
	linux-info_pkg_setup
}

src_configure() {
	local rundir="/run"

	local emesonargs=(
		--localstatedir="${EPREFIX}/var"
		-D asserts=false
		-D checks=false
		-D containers=false
		-D dbus_user=messagebus
		-D default_library=$(usex static-libs both shared)
		-D kqueue=disabled
		-D libaudit=disabled
		-D message_bus=true
		-D qt_help=disabled
		-D runtime_dir="${EPREFIX}${rundir}"
		-D selinux=disabled
		-D session_socket_dir="${EPREFIX}"/tmp
		-D system_pid_file="${EPREFIX}${rundir}"/dbus.pid
		-D system_socket="${EPREFIX}${rundir}"/dbus/system_bus_socket
		-D systemd_system_unitdir=$(usex systemd "${EPREFIX}/usr/lib/systemd/system" "false")
		-D systemd_user_unitdir=$(usex systemd "${EPREFIX}/usr/lib/systemd/user" "false")
		-D xml_docs=disabled
		-Dinstalled_tests=false
		$(meson_feature apparmor)
		$(meson_feature inotify)
		$(meson_feature systemd)
		$(meson_feature test modular_tests)
		$(meson_feature valgrind)
		$(meson_feature X x11_autolaunch)
		$(meson_use debug stats)
		$(meson_use debug verbose_mode)
		$(meson_use systemd user_session)
		$(meson_use tools)
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	if use X; then
		exeinto /etc/X11/xinit/xinitrc.d
		doexe "${FILESDIR}"/80-dbus
	fi

	# needs to exist for dbus sessions to launch
	keepdir /usr/share/dbus-1/services

	# let the init script create the /var/run/dbus directory
	rm -rf "${ED}"/var/run
	rm -rf "${ED}"/run
	rm -rf "${ED}"/var/lib

	cat > "${T}"/"${PN}"-sysusers <<- EOF || die
		g messagebus -
		u! messagebus 101 "System Message Bus" /run/dbus /usr/bin/nologin
	EOF

	cat > "${T}"/"${PN}"-tmpfiles <<- EOF || die
		d /var/lib/dbus 0755 - - -
		L /var/lib/dbus/machine-id - - - - /etc/machine-id
	EOF

	newsysusers "${T}/${PN}-sysusers" "${PN}.conf"
	newtmpfiles "${T}/${PN}-tmpfiles" "${PN}.conf"
}

pkg_postinst() {
	sysusers_process
	tmpfiles_process
}
