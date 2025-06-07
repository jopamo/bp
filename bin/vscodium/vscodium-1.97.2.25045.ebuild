# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A community-driven, freely-licensed binary distribution of Microsoft's VSCode"
HOMEPAGE="https://vscodium.com/"
SRC_URI="
	amd64? ( https://github.com/VSCodium/vscodium/releases/download/${PV}/VSCodium-linux-x64-${PV}.tar.gz -> ${P}-amd64.tar.gz )
	arm64? ( https://github.com/VSCodium/vscodium/releases/download/${PV}/VSCodium-linux-arm64-${PV}.tar.gz -> ${P}-arm64.tar.gz )
"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="strip"

QA_PREBUILT="opt/vscodium/*"

src_install() {
	mkdir -p "${ED}"/opt/vscodium/
	cp -rp "${S}"/* "${ED}"/opt/vscodium/

	fperms 4775 /opt/vscodium/chrome-sandbox
}
