# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="inih (INI not invented here) simple .INI file parser"
HOMEPAGE="https://github.com/benhoyt/inih"

SNAPSHOT=95bc02a507a624b25c51a791cb3dd827abe8ede8
SRC_URI="https://github.com/benhoyt/inih/archive/${SNAPSHOT}.tar.gz -> inih-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/inih-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_configure() {
	local emesonargs=(
		-Ddefault_library=$(usex static-libs both shared)
		-Ddistro_install=true
		-Dwith_INIReader=true
	)

	meson_src_configure
}
