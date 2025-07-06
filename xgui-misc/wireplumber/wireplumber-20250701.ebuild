# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Replacement for pipewire-media-session"
HOMEPAGE="https://gitlab.freedesktop.org/pipewire/wireplumber"
SNAPSHOT=faf042a82b16334f9ec2ca78830b56825d47ac98
SRC_URI="https://github.com/PipeWire/wireplumber/archive/${SNAPSHOT}.tar.gz -> wireplumber-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/wireplumber-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="arm64 amd64"

IUSE="system-service systemd test"

DEPEND="
	app-lang/lua
	xgui-misc/pipewire
"

src_configure() {
	local emesonargs=(
		-Ddaemon=true
		-Dtools=true
		-Dmodules=true
		-Ddoc=disabled
		-Dintrospection=disabled
		-Dsystem-lua=true
		$(meson_feature systemd)
		$(meson_use system-service systemd-system-service)
		$(meson_use systemd systemd-user-service)
		$(meson_use test tests)
		$(meson_use test dbus-tests)
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	insinto /etc
	doins -r "${ED}"/usr/share/wireplumber
}
