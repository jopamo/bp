# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Netwide Assembler for x86 and x86_64"
HOMEPAGE="http://www.nasm.us/"
SNAPSHOT=7a5502142b735fe62866963fa0bf3182808996b2
SRC_URI="https://github.com/netwide-assembler/nasm/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-lang/perl"

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
