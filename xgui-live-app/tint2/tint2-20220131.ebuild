# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Lightweight panel/taskbar for Linux"
HOMEPAGE="https://gitlab.com/o9000/tint2"

SNAPSHOT=f3aa2ef0c61838ce16a88733e4d31990c5b5cdf2
SRC_URI="https://gitlab.com/o9000/tint2/-/archive/${SNAPSHOT}/tint2-${SNAPSHOT}.tar.bz2 -> tint2-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/tint2-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="battery startup-notification svg tint2conf"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-Ddocdir="${EPREFIX}/usr/share/doc/${PF}"
		-DENABLE_BATTERY="$(usex battery)"
		-DENABLE_TINT2CONF="$(usex tint2conf)"
		-DENABLE_SN="$(usex startup-notification)"
		-DENABLE_RSVG="$(usex svg)"
	)
	cmake_src_configure
}
