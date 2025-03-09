# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Automated Encryption Framework"
HOMEPAGE="https://github.com/latchset/clevis"

SNAPSHOT=a13c1509aa8b1a132a2899ba9e3ad65ed8c7f2f7
SRC_URI="https://github.com/latchset/clevis/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"
