# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="A library for configuring and customizing font access"
HOMEPAGE="http://fontconfig.org/"
SNAPSHOT=a9bd4fbc15c074e25308c1fbc57f4b9a485051b3
SRC_URI="https://gitlab.freedesktop.org/fontconfig/fontconfig/-/archive/${SNAPSHOT}/fontconfig-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/fontconfig-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
#KEYWORDS="amd64 arm64"
#api/abi breaks are frequent

IUSE="+debug"

DEPEND="xgui-lib/freetype"
RDEPEND="${DEPEND}"

RESTRICT="nostrip"

src_configure() {
	local emesonargs=(
		-Dbuildtype=$(usex debug debug release)
		-Dstrip=$(usex debug false true)
	)

	if use debug ; then
		filter-lto
		filter-flags -O3 -O2
		append-flags -Og -g -fno-omit-frame-pointer
	fi

	meson_src_configure
}
