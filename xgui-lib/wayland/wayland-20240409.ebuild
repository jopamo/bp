# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Wayland protocol libraries"
HOMEPAGE="https://wayland.freedesktop.org/ https://gitlab.freedesktop.org/wayland/wayland"

SNAPSHOT=c5d145a602581ee70f3ee87566ccb5cf1ff6cce8
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
