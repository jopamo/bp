# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Overwrite files with iterative patterns"
HOMEPAGE="https://github.com/chaos/scrub"

SNAPSHOT=9b4267e58581e4629c542557d5c58e39a39fa0e2
SRC_URI="https://github.com/chaos/scrub/archive/${SNAPSHOT}.tar.gz -> scrub-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/scrub-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	cp "${FILESDIR}/configure.ac" "${S}"
	cp "${FILESDIR}/Makefile.am" "${S}/libscrub/"

	default
	eautoreconf
}
