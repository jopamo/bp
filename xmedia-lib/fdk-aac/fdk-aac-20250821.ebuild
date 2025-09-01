# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Fraunhofer AAC codec library"
HOMEPAGE="https://sourceforge.net/projects/opencore-amr/"
SNAPSHOT=d8e6b1a3aa606c450241632b64b703f21ea31ce3
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
