# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A nice emerge.log parser"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Perl"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/gentoo-perl/genlop.git"
	inherit git-r3
	KEYWORDS="~amd64 ~arm64"
else
	SNAPSHOT=32d55e9c5b960d4e4d28884d9d04e6b151d419a1
	SRC_URI="https://github.com/gentoo-perl/genlop/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="GPL-2"
SLOT="0"

DEPEND="dev-lang/perl"

src_install() {
	dobin genlop
}
