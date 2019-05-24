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

RDEPEND="
	!readline? ( libedit? ( lib-dev/libedit:= ) )
	readline? (
		>=lib-sys/readline-4.1:0=
		>=lib-sys/ncurses-5.2:=
	)
"
DEPEND="
	${RDEPEND}
	sys-app/ed
	sys-devel/flex
	sys-devel/bison
"

PATCHES=(
			${FILESDIR}/26f275502dd28114e78bc098fed81acde1d86d62.patch
			${FILESDIR}/2dcee958a412210cd1260f866ac199f68f28cf08.patch
		)

src_configure() {
	local myconf=(
		$(use_with readline)
	)
	if use readline ; then
		myconf+=( --without-libedit )
	else
		myconf+=( $(use_with libedit) )
	fi
	use static && append-ldflags -static

	econf "${myconf[@]}"

	# Do not regen docs -- configure produces a small fragment that includes
	# the version info which causes all pages to regen (newer file). #554774
	touch -r doc doc/*
}

src_compile() {
	emake -j1 AR="$(tc-getAR)"
}
