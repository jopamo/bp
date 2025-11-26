# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="unix-like reverse engineering framework and commandline tools"
HOMEPAGE="http://www.radare.org"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/radareorg/radare2"
	inherit git-r3
else
	SNAPSHOT=262684f8e4cbcee37dce79960fe167beefbe04c4
	SRC_URI="https://github.com/radareorg/radare2/archive/${SNAPSHOT}.tar.gz -> radare2-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/radare2-${SNAPSHOT}"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

DEPEND="
	app-compression/libzip
	lib-misc/xxhash
"

src_configure() {
	filter-flags -Wl,-z,defs -flto*
	append-flags -fno-ipa-sra
	filter-flags -fipa-pta

	econf \
	--with-syslz4 \
	--with-sysmagic \
	--with-libatomic \
	--with-syszip \
	--with-sysxxhash \
	--with-ssl \
	--with-ssl-crypto
}
