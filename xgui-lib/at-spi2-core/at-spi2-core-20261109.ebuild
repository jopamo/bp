# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="D-Bus accessibility specifications and registration daemon"
HOMEPAGE="https://wiki.gnome.org/Accessibility"
SNAPSHOT=10fbc4b6efc9261f05782ea7f8ca4b41b9a46356
SRC_URI="https://gitlab.gnome.org/GNOME/at-spi2-core/-/archive/${SNAPSHOT}/at-spi2-core-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/at-spi2-core-${SNAPSHOT}

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	virtual/dbus
	lib-core/glib
"
BDEPEND="
	app-build/gettext
	app-dev/gtk-doc-am
	app-dev/intltool
	app-dev/pkgconf
"

PATCHES=( "${FILESDIR}/${PN}-direct-connection-test-bus.patch" )

src_test() {
	local runtime_dir status=0
	runtime_dir=$(mktemp -d /tmp/atspi-test.XXXXXX) || die
	XDG_RUNTIME_DIR="${runtime_dir}" dbus-run-session -- bash -c '
		unset NO_AT_BRIDGE
		export AT_SPI_BUS_ADDRESS="${DBUS_SESSION_BUS_ADDRESS}"
		"${1}/registryd/at-spi2-registryd" &
		registry_pid=$!
		trap '\''kill "${registry_pid}"; wait "${registry_pid}"'\'' EXIT
		trap "exit 1" HUP INT TERM
		gdbus wait --session --timeout 10 org.a11y.atspi.Registry || exit 1
		shift
		"$@"
	' bash "${BUILD_DIR}" meson test -C "${BUILD_DIR}" \
		--print-errorlogs --num-processes "$(makeopts_jobs)" || status=$?
	rm -rf "${runtime_dir}" || die
	[[ ${status} == 0 ]] || die "AT-SPI tests failed"
}

src_install() {
	meson_src_install

	cat > "${T}"/99at-spi2-core <<- EOF || die
		NO_AT_BRIDGE=1
	EOF
	doenvd "${T}"/99at-spi2-core

	rm -rf "${ED}"/etc/xdg/autostart
	rm "${ED}"/usr/share/dbus-1/services/org.a11y.Bus.service || die
	rm "${ED}"/usr/share/dbus-1/accessibility-services/org.a11y.atspi.Registry.service || die

}
