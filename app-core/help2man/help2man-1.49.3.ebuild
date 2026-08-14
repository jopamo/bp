# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="GNU utility to convert program --help output to a man page"
HOMEPAGE="https://www.gnu.org/software/help2man/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="nls"

DEPEND="
	app-lang/perl
	nls? ( core-perl/libintl-perl )
"
RDEPEND="nls? ( core-perl/libintl-perl )"
BDEPEND="nls? ( app-build/gettext )"

src_configure() {
	econf $(use_enable nls)
}
