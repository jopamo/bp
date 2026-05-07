# Distributed under the terms of the GNU General Public License v2

inherit linux-info meson doins qa-policy

DESCRIPTION="Desktop-friendly D-Bus build with systemd user-bus, tools, and X11 integration"
HOMEPAGE="https://dbus.freedesktop.org/"
SNAPSHOT=4f5796a37dd303b6030127d20cba52c72523df79
SRC_URI="https://gitlab.freedesktop.org/dbus/dbus/-/archive/${SNAPSHOT}/dbus-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/dbus-${SNAPSHOT}

LICENSE="|| ( AFL-2.1 GPL-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="apparmor debug inotify static-libs test valgrind"

DEPEND="
	lib-core/expat
	apparmor? ( app-core/apparmor )
	valgrind? ( app-dev/valgrind )
	app-core/systemd
	xgui-lib/libX11
"
RDEPEND="!app-core/dbus"
BDEPEND="
	app-build/autoconf-archive
	app-dev/pkgconf
"

pkg_setup() {
	CONFIG_CHECK="~EPOLL"
	linux-info_pkg_setup
}

src_configure() {
	qa-policy-configure

	local emesonargs=(
		--localstatedir="${EPREFIX}/var"
		-D default_library=$(usex static-libs both shared)
		-D kqueue=disabled
		-D libaudit=disabled
		-D message_bus=true
		-D qt_help=disabled
		-D selinux=disabled
		-D systemd=enabled
		-D systemd_system_unitdir="${EPREFIX}/usr/lib/systemd/system"
		-D systemd_user_unitdir="${EPREFIX}/usr/lib/systemd/user"
		-D tools=true
		-D user_session=true
		-D x11_autolaunch=enabled
		-D xml_docs=disabled
		$(meson_feature apparmor)
		$(meson_feature inotify)
		$(meson_feature test modular_tests)
		$(meson_feature valgrind)
		$(meson_use debug stats)
		$(meson_use debug verbose_mode)
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	exeinto /etc/X11/xinit/xinitrc.d
	doexe "${FILESDIR}"/80-dbus

	# keep runtime state out of the image; create it via sysusers/tmpfiles
	rm -rf "${ED}"/run
	rm -rf "${ED}"/var/run
	rm -rf "${ED}"/var/lib

	cat > "${T}"/"${PN}"-sysusers <<- EOF2 || die
		g messagebus 101 - -
		u! messagebus 101:101 "D-Bus system message bus" / /usr/bin/nologin
	EOF2

	cat > "${T}"/"${PN}"-tmpfiles <<- EOF2 || die
		d /var/lib/dbus 0755 - - -
		L /var/lib/dbus/machine-id - - - - /etc/machine-id
	EOF2

	newsysusers "${T}/${PN}-sysusers" dbus.conf
	newtmpfiles "${T}/${PN}-tmpfiles" dbus.conf

	qa-policy-install
}

pkg_postinst() {
	sysusers_process
	tmpfiles_process
}
