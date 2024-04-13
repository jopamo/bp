# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Fraunhofer AAC codec library"
HOMEPAGE="https://sourceforge.net/projects/opencore-amr/"

SNAPSHOT=716f4394641d53f0d79c9ddac3fa93b03a49f278
SRC_URI="https://github.com/mstorsjo/fdk-aac/archive/${SNAPSHOT}.tar.gz -> fdk-aac-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/fdk-aac-${SNAPSHOT}"

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
