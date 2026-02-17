# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools libtool dot-a

DESCRIPTION="YAML 1.1 parser and emitter written in C"
HOMEPAGE="https://github.com/yaml/libyaml"
SRC_URI="https://github.com/yaml/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

RESTRICT="!test? ( test )"

src_prepare() {
	use static-libs && lto-guarantee-fat

	default

	# conditionally remove tests
	if ! use test; then
		sed -i -e 's: tests::g' Makefile* || die
	fi

	elibtoolize
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	use static-libs && strip-lto-bytecode
	find "${D}" -name '*.la' -delete || die
}
