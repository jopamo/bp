# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="groovy little assembler"
HOMEPAGE="http://www.nasm.us/"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/netwide-assembler/nasm"
	inherit git-r3
else
	SRC_URI="http://www.nasm.us/pub/nasm/releasebuilds/${PV/_}/${P/_}.tar.xz"
	#SNAPSHOT=3aebb20f123033dcd767f0abc46b18cbefed8091
	#SRC_URI="https://github.com/netwide-assembler/nasm/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	#S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-lang/perl"
