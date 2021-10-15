# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="GNU regular expression matcher"
HOMEPAGE="https://www.gnu.org/software/grep/"
SRC_URI="
	https://1g4.org/files/${P}.tar.xz
	mirror://gnu/${PN}/${P}.tar.xz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="pcre static"

LIB_DEPEND="pcre? ( lib-core/libpcre[static-libs(+)] )"
RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )"
DEPEND="static? ( ${LIB_DEPEND} )"

BDEPEND="
	dev-util/pkgconf
	sys-devel/texinfo
"

src_configure() {
	use static && append-ldflags -static

	local myconf=(
		--disable-nls
		$(use_enable pcre perl-regexp)
	)

	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
