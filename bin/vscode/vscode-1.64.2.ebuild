# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils

DESCRIPTION="Multiplatform Visual Studio Code from Microsoft"
HOMEPAGE="https://code.visualstudio.com"
SRC_URI="
	amd64? ( https://update.code.visualstudio.com/${PV}/linux-x64/stable -> ${P}-amd64.tar.gz )
	arm64? ( https://update.code.visualstudio.com/${PV}/linux-arm64/stable -> ${P}-arm64.tar.gz )
"
S="${WORKDIR}/VSCode-linux-x64"

LICENSE="Apache-2.0	BSD	BSD-1 BSD-2	BSD-4 CC-BY-4.0	ISC	LGPL-2.1+ Microsoft-vscode
	MIT	MPL-2.0	openssl	PYTHON TextMate-bundle Unlicense UoI-NCSA W3C"
SLOT="0"
KEYWORDS="amd64 arm64"


RESTRICT="mirror bindist strip"

QA_PREBUILT="opt/${PN}/*"

src_install() {
	mkdir -p "${ED}"/opt/${PN}/
	cp -rp "${S}"/* "${ED}"/opt/${PN}/

	fperms 4775 /opt/vscode/chrome-sandbox
}
