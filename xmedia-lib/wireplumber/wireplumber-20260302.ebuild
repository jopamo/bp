# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Replacement for pipewire-media-session"
HOMEPAGE="https://gitlab.freedesktop.org/pipewire/wireplumber"
SNAPSHOT=355bb0fb8fe0ee99884952ac1e0ca64725536e4d
SRC_URI="https://github.com/PipeWire/wireplumber/archive/${SNAPSHOT}.tar.gz -> wireplumber-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/wireplumber-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="arm64 amd64"

IUSE="system-service systemd test"

DEPEND="
	app-lang/lua
	xmedia-lib/pipewire
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
