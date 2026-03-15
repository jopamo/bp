# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qa-policy toolchain-funcs

DESCRIPTION="lossless data compressor based on the LZMA algorithm"
HOMEPAGE="https://www.nongnu.org/lzip/lzip.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test"

src_configure() {
	qa-policy-configure

	# not autotools-based
	./configure \
		--prefix="${EPREFIX}"/usr \
		CXX="$(tc-getCXX)" \
		CPPFLAGS="${CPPFLAGS}" \
		CXXFLAGS="${CXXFLAGS}" \
		LDFLAGS="${LDFLAGS}" || die
}

src_test() {
	emake check
}

src_install() {
	default

	qa-policy-install
}
