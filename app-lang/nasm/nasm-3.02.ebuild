# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Netwide Assembler for x86 and x86_64"
HOMEPAGE="https://www.nasm.us/"
SRC_URI="https://www.nasm.us/pub/nasm/releasebuilds/${PV}/${P}.tar.xz"

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

}
