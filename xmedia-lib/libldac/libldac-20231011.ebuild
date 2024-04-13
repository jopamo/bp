# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A dispatcher for AOSP libldac"
HOMEPAGE="https://github.com/EHfive/ldacBT"

CMAKE_SNAP=af2dd23979453bcd1cad7c4086af5fb421a955c5
SNAPSHOT=2efdd91222c4c5f929335f34cbc3b576343cf1d2
SRC_URI="https://github.com/EHfive/ldacBT/archive/${CMAKE_SNAP}.tar.gz -> ldacBT-${CMAKE_SNAP}.tar.gz
		https://android.googlesource.com/platform/external/libldac/+archive/${SNAPSHOT}.tar.gz -> libldac-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/ldacBT-${CMAKE_SNAP}"

LICENSE="Apache-2"
SLOT="0"
KEYWORDS="arm64 amd64"

src_unpack() {
	tar xf "${DISTDIR}"/ldacBT-${CMAKE_SNAP}.tar.gz -C "${WORKDIR}"
	tar xf "${DISTDIR}"/libldac-${SNAPSHOT}.tar.gz -C "${S}"/libldac/
}
