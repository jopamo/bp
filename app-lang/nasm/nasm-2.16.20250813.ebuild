# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="nasm-$(ver_cut 1-2).xx"


DESCRIPTION="Netwide Assembler for x86 and x86_64"
HOMEPAGE="http://www.nasm.us/"
SNAPSHOT=e2ccd5de268fc4bda5aa4313a79859827c3adc82
SRC_URI="https://github.com/netwide-assembler/nasm/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-lang/perl"

QA_CONFIG_IMPL_DECL_SKIP=(
	"_BitScanReverse*"
	"cpu_to_le*"
	"__cpu_to_le*"
	"_byteswap_*"
	typeof
)

src_prepare() {
	  sed -i \
    -e '/INSTALL_DATA.*nasm\.1/d' \
    -e '/INSTALL_DATA.*ndisasm\.1/d' \
    -e '/MKDIR_P.*man1/d' \
    -e '/^manpages: /c\manpages:\n\t@true' \
    Makefile.in || die
  default

	./autogen.sh
	default
}
