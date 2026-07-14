# Distributed under the terms of the GNU General Public License v2

inherit linux-info meson doins qa-policy

DESCRIPTION="A message bus system, a simple way for applications to talk to each other"
HOMEPAGE="https://dbus.freedesktop.org/"
SNAPSHOT=f64ae3cafdcf31606401171bb0e8fe3fccc761c2
SRC_URI="https://gitlab.freedesktop.org/dbus/dbus/-/archive/${SNAPSHOT}/dbus-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/dbus-${SNAPSHOT}

LICENSE="|| ( AFL-2.1 GPL-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="apparmor debug inotify static-libs systemd test user-session valgrind"

DEPEND="
	lib-core/expat
	apparmor? ( app-core/apparmor )
	valgrind? ( app-dev/valgrind )
	systemd? ( app-core/systemd )
"
BDEPEND="
	app-build/autoconf-archive
	app-dev/pkgconf
"
RDEPEND="!app-core/dbus-x11"

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
		-D systemd_system_unitdir=$(usex systemd "${EPREFIX}/usr/lib/systemd/system" "false")
		-D systemd_user_unitdir=$(usex systemd "${EPREFIX}/usr/lib/systemd/user" "false")
		-D tools=false
		-D x11_autolaunch=disabled
		-D xml_docs=disabled
		$(meson_feature apparmor)
		$(meson_feature inotify)
		$(meson_feature systemd)
		$(meson_feature test modular_tests)
		$(meson_feature valgrind)
		$(meson_use debug stats)
		$(meson_use debug verbose_mode)
		$(meson_use user-session user_session)
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	# keep runtime state out of the image; create it via sysusers/tmpfiles
	rm -rf "${ED}"/run
	rm -rf "${ED}"/var/run
	rm -rf "${ED}"/var/lib

	cat > "${T}"/"${PN}"-sysusers <<- EOF || die
		g messagebus 101 - -
		u! messagebus 101:101 "D-Bus system message bus" / /usr/bin/nologin
	EOF

	cat > "${T}"/"${PN}"-tmpfiles <<- EOF || die
		d /var/lib/dbus 0755 - - -
		L /var/lib/dbus/machine-id - - - - /etc/machine-id
	EOF

	newsysusers "${T}/${PN}-sysusers" "${PN}.conf"
	newtmpfiles "${T}/${PN}-tmpfiles" "${PN}.conf"

	qa-policy-install
}

pkg_postinst() {
	sysusers_process
	tmpfiles_process
}
