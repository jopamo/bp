# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Automated Encryption Framework"
HOMEPAGE="https://github.com/latchset/clevis"
SNAPSHOT=dcabb67e3d8ce3d09980005af541d844b32bd84b
SRC_URI="https://github.com/latchset/clevis/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/clevis-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-core/systemd
	app-crypto/jose
	app-crypto/luksmeta
	app-crypto/tpm2-tools
	app-fs/cryptsetup
	lib-core/jansson
"
RDEPEND="
	${DEPEND}
	app-core/bash
	app-net/curl
"
