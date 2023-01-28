# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="Fraunhofer AAC codec library"
HOMEPAGE="https://sourceforge.net/projects/opencore-amr/"
EGIT_REPO_URI="https://github.com/mstorsjo/${PN}.git"

LICENSE="FraunhoferFDK"
SLOT="0"
KEYWORDS="arm64 amd64"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--disable-static
		--disable-example
	)
	ECONF_SOURCE=${S} econf "${myeconfargs[@]}"
}
