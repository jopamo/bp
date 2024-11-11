# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="the Ogg media file format library"
HOMEPAGE="https://xiph.org/ogg/"

SNAPSHOT=db5c7a49ce7ebda47b15b78471e78fb7f2483e22
SRC_URI="https://github.com/xiph/ogg/archive/${SNAPSHOT}.tar.gz -> ogg-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/ogg-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="keep-la static-libs"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_install() {
	default

	if ! use keep-la; then
		find "${ED}" -name '*.la' -delete || die
	fi
}
