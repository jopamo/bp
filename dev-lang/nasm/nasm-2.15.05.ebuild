# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="groovy little assembler"
HOMEPAGE="http://www.nasm.us/"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/netwide-assembler/nasm"
	inherit git-r3
else
	SRC_URI="http://www.nasm.us/pub/nasm/releasebuilds/${PV/_}/${P/_}.tar.xz"
fi

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="dev-lang/perl"
