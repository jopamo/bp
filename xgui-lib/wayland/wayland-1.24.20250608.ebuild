# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="$(ver_cut 1-2)"

inherit meson

DESCRIPTION="Wayland protocol libraries"
HOMEPAGE="https://wayland.freedesktop.org/ https://gitlab.freedesktop.org/wayland/wayland"

SNAPSHOT=e35f1efb5957e78dd61d36186c4ed64ea423cf7a
SRC_URI="https://gitlab.freedesktop.org/wayland/wayland/-/archive/${SNAPSHOT}/wayland-${SNAPSHOT}.tar.bz2 -> wayland-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/wayland-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="app-dev/pkgconf"
DEPEND="
	lib-core/expat
	lib-core/libxml2
	lib-core/libffi
"

src_configure() {
	local emesonargs=(
		-Ddocumentation=false
		)
		meson_src_configure
}
