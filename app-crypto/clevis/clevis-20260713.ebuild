# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Automated Encryption Framework"
HOMEPAGE="https://github.com/latchset/clevis"
SNAPSHOT=bcac5294e205a0b7d81aad6319f807e762266426
SRC_URI="https://github.com/latchset/clevis/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/clevis-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"
