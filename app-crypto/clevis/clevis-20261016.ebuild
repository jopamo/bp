# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Automated Encryption Framework"
HOMEPAGE="https://github.com/latchset/clevis"
SNAPSHOT=a0be5777495b0ddb28f8452c4b7276d308d4b3ee
SRC_URI="https://github.com/latchset/clevis/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/clevis-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"
