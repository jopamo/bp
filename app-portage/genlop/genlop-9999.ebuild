# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="A nice emerge.log parser"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Perl"
EGIT_REPO_URI="https://github.com/gentoo-perl/genlop.git"

KEYWORDS="amd64 arm64"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="dev-lang/perl"

src_install() {
	dobin genlop
}
