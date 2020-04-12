# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Used to generate Makefile.in from Makefile.am"
HOMEPAGE="https://www.gnu.org/software/automake/"

SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"
KEYWORDS="amd64 arm64"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="dev-lang/perl
	>=sys-devel/autoconf-2.69:*
	sys-devel/gnuconfig"
DEPEND="${RDEPEND}
	sys-app/help2man"

src_prepare() {
	default
	export WANT_AUTOCONF=2.5
	./bootstrap || die
}
