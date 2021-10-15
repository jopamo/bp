# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="GNU regular expression matcher"
HOMEPAGE="https://www.gnu.org/software/grep/"
SRC_URI="
	https://1g4.org/files/${P}.tar.xz
	mirror://gnu/diffutils/${P}.tar.xz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="pcre static"

LIB_DEPEND="pcre? ( >=lib-core/libpcre-7.8-r1[static-libs(+)] )"
RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )"

DEPEND="${RDEPEND}
	static? ( ${LIB_DEPEND} )"

BDEPEND="
	dev-util/pkgconf
	sys-devel/texinfo
"

src_prepare() {
	default
	sed -i \
		-e "s:@SHELL@:${EPREFIX}/bin/sh:g" \
		src/egrep.sh || die #523898
}

src_configure() {
	use static && append-ldflags -static
	# Always use pkg-config to get lib info for pcre.
	export ac_cv_search_pcre_compile=$(
		usex pcre "$($(tc-getPKG_CONFIG) --libs $(usex static --static '') libpcre)" ''
	)
	econf \
		--bindir="${EPREFIX}"/usr/bin \
		--disable-nls
		$(use_enable pcre perl-regexp)
}
