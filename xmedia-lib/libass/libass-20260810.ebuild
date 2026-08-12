# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="Library for SSA/ASS subtitles rendering"
HOMEPAGE="https://github.com/libass/libass"
SNAPSHOT=3087d2b2ffda76602a17f9b09d25cb8addc8d313
SRC_URI="https://github.com/libass/libass/archive/${SNAPSHOT}.tar.gz -> libass-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libass-${SNAPSHOT}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RDEPEND="
	fonts/fontconfig
	xgui-lib/freetype
	xgui-lib/harfbuzz[truetype]
"
BDEPEND="
	app-dev/pkgconf
	app-lang/nasm
"

src_prepare() {
	qa-policy-configure
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-require-system-font-provider
		--enable-fontconfig
		$(use_enable static-libs static)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_install() {
	default
	qa-policy-install
}
