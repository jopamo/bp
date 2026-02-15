# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A maintained ctags implementation"
HOMEPAGE="https://ctags.io/"
SNAPSHOT=7023fdb01d52a23432bbeaead784d8ba0da0d2e4
SRC_URI="https://github.com/universal-ctags/ctags/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT CC-BY-3.0"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local econfargs=(
		--disable-etags
		--enable-tmpdir=/tmp
	)
	econf "${econfargs[@]}"
}
