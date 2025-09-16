# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Trusted Platform Module (TPM2.0) tools"
HOMEPAGE="https://github.com/tpm2-software/tpm2-tools"
SNAPSHOT=c2d1ee7c60dbcc24c4251eb1a99138d2d29fad73
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
