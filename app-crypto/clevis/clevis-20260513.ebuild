# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Automated Encryption Framework"
HOMEPAGE="https://github.com/latchset/clevis"
SNAPSHOT=6df9b6969da3fa438604cc711cb231ba2fa52a4d
SRC_URI="https://github.com/latchset/clevis/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/clevis-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"
