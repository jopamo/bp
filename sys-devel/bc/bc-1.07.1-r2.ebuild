# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Handy console-based calculator utility"
HOMEPAGE="https://www.gnu.org/software/bc/bc.html"
SRC_URI="mirror://gnu/bc/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="libedit readline static"

DEPEND="
	sys-app/ed
	sys-devel/flex
	sys-devel/bison
	readline? ( lib-sys/readline )
	libedit? ( lib-dev/libedit )
"

PATCHES=(
	"${FILESDIR}"/26f275502dd28114e78bc098fed81acde1d86d62.patch
	"${FILESDIR}"/2dcee958a412210cd1260f866ac199f68f28cf08.patch
		)

src_configure() {
	use static && append-ldflags -static

	local myconf=(
		$(use_with libedit)
		$(use_with readline)
	)

	ECONF_SOURCE=${S} econf "${myconf[@]}"

	touch -r doc doc/*
}

src_compile() {
	emake -j1 AR="$(tc-getAR)"
}
