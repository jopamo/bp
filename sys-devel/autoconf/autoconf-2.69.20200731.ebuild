# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Used to create autoconfiguration files"
HOMEPAGE="https://www.gnu.org/software/autoconf/autoconf.html"
SRC_URI="https://1g4.org/files/${PN}-$(ver_cut 3).tar.xz"
S="${WORKDIR}/${PN}-$(ver_cut 3)"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND=">=sys-devel/m4-1.4.16
	>=dev-lang/perl-5.6"

src_prepare() {
	default
	sed -i -e "s/UNKNOWN/${PV}/g" "configure" || die
}
