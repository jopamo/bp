# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit multilib-minimal

DESCRIPTION="the Ogg media file format library"
HOMEPAGE="https://xiph.org/ogg/"
SRC_URI="https://downloads.xiph.org/releases/ogg/${P}.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="static-libs"

DOCS=( AUTHORS CHANGES )

MULTILIB_WRAPPED_HEADERS=(
	/usr/include/ogg/config_types.h
)

multilib_src_configure() {
	local myeconfargs=(
		--htmldir="${EPREFIX}"/usr/share/doc/${PF}/html
		$(use_enable static-libs static)
		)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

multilib_src_install_all() {
	einstalldocs
	find "${ED}" -name "*.la" -delete || die
}
