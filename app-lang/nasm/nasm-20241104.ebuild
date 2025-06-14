# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="groovy little assembler"
HOMEPAGE="http://www.nasm.us/"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/netwide-assembler/nasm"
	inherit git-r3
else
SNAPSHOT=888d9ab55012d25059da81fed6575ef3a004726f
	SRC_URI="https://github.com/netwide-assembler/nasm/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-lang/perl"
