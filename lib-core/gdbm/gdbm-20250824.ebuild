# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=fb46d987d613e4d56981d30f2b9f34288ef42858

inherit autotools dot-a

DESCRIPTION="Standard GNU database libraries"
HOMEPAGE="https://www.gnu.org/software/gdbm/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/1g4-mirror/gdbm"
	inherit git-r3
	EGIT_COMMIT="${SNAPSHOT}"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://github.com/1g4-mirror/gdbm/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/${PN}-${SNAPSHOT}"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="
	app-core/bash
	lib-core/readline
"

src_prepare() {
	use static-libs && lto-guarantee-fat

	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		--with-readline
		--disable-nls
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs && strip-lto-bytecode
}
