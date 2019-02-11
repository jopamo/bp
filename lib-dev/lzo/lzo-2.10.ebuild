# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal toolchain-funcs

DESCRIPTION="An extremely fast compression and decompression library"
HOMEPAGE="http://www.oberhumer.com/opensource/lzo/"
SRC_URI="http://www.oberhumer.com/opensource/lzo/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="amd64 arm64"
IUSE="examples static-libs"

multilib_src_configure() {
	ECONF_SOURCE=${S} \
	econf \
		--enable-shared \
		$(use_enable static-libs static)
}

multilib_src_install() {
	emake DESTDIR="${D}" install
}

multilib_src_install_all() {
	rm "${ED}"/usr/share/doc/${PF}/COPYING || die

	if use examples; then
		docinto examples
		dodoc examples/*.{c,h}
	fi

	find "${ED}" -name '*.la' -delete || die
}
