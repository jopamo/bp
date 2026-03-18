# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Trusted Platform Module (TPM2.0) tools"
HOMEPAGE="https://github.com/tpm2-software/tpm2-tools"
SNAPSHOT=bc4cf8bca83c15deb62af448f609caa8ba0111da
SRC_URI="https://github.com/tpm2-software/tpm2-tools/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/tpm2-tools-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-compression/zstd
	app-crypto/tpm2-tss
	app-fs/efivar
	app-net/curl
	virtual/ssl
"

src_prepare() {
	sed -i 's/git describe --tags --always --dirty > VERSION/echo "${PV}" > VERSION/' bootstrap
	./bootstrap
	default
	eautoreconf
}
