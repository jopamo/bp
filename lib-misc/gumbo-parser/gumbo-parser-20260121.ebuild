# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools qa-policy

DESCRIPTION="An HTML5 parsing library in pure C99"
HOMEPAGE="https://github.com/google/gumbo-parser"
SNAPSHOT=6fd66040a8eecdb1359a6de221f3f9325cf52ba6
SRC_URI="https://github.com/google/gumbo-parser/archive/${SNAPSHOT}.tar.gz -> gumbo-parser-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/gumbo-parser-${SNAPSHOT}"

LICENSE="apache"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"
BDEPEND="app-dev/patchelf"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	qa-policy-configure

	local myconf=(
		$(use_enable static-libs static)
		--disable-silent-rules
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	qa-policy-install
}
