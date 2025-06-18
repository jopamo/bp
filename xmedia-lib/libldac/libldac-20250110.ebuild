# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A dispatcher for AOSP libldac"
HOMEPAGE="https://github.com/EHfive/ldacBT"

CMAKE_SNAP=af2dd23979453bcd1cad7c4086af5fb421a955c5
SNAPSHOT=eeee1a3f5f8df1282e3a6d297085885fd886737b
SRC_URI="https://github.com/1g4-mirror/libldac/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"

SRC_URI="https://github.com/1g4-mirror/libldac/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz
		https://github.com/EHfive/ldacBT/archive/${CMAKE_SNAP}.tar.gz -> ldacBT-${CMAKE_SNAP}.tar.gz"
S="${WORKDIR}/ldacBT-${CMAKE_SNAP}"

LICENSE="Apache-2"
SLOT="0"
KEYWORDS="arm64 amd64"

src_unpack() {
	tar xf "${DISTDIR}"/ldacBT-${CMAKE_SNAP}.tar.gz -C "${WORKDIR}"
	tar xf "${DISTDIR}"/libldac-${SNAPSHOT}.tar.gz -C "${S}"
	rm -rf "${S}"/libldac
	mv "${S}"/libldac-* "${S}"/libldac
}
