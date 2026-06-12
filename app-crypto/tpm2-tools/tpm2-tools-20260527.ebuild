# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="Trusted Platform Module (TPM2.0) tools"
HOMEPAGE="https://github.com/tpm2-software/tpm2-tools"
SNAPSHOT=b07deaacdc20238431cb58d2550ed33dc853f212
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
