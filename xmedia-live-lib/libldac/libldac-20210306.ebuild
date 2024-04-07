# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A dispatcher for AOSP libldac"
HOMEPAGE="https://github.com/EHfive/ldacBT"

SNAPSHOT=af2dd23979453bcd1cad7c4086af5fb421a955c5
SRC_URI="https://github.com/EHfive/ldacBT/archive/${SNAPSHOT}.tar.gz -> ldacBT-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/ldacBT-${SNAPSHOT}"

LICENSE="Apache-2"
SLOT="0"
KEYWORDS="arm64 amd64"
