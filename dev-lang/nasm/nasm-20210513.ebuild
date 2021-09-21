# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic autotools

DESCRIPTION="A cross-platform x86 assembler with an Intel-like syntax"
HOMEPAGE="http://www.nasm.us/"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/netwide-assembler/nasm"
	inherit git-r3
else
	SNAPSHOT=e2ed7b7e125e03646d3be537b11d1b46b9c3f506
	SRC_URI="https://github.com/netwide-assembler/nasm/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="dev-lang/perl"

src_prepare() {
	sed -i '/nasm.1/d' Makefile.in
	sed -i '/ndisasm.1/d' Makefile.in

	./autogen.sh
	default
}
