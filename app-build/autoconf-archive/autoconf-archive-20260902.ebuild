# Distributed under the terms of the GNU General Public License v2

PROPERTIES+=" source-payload"

DESCRIPTION="GNU Autoconf Macro Archive"
HOMEPAGE="
	https://www.gnu.org/software/autoconf-archive/
	https://github.com/autoconf-archive/autoconf-archive
"
SNAPSHOT=92c33ce5c3eeabc7c60ca92b1a6e813bb6a5ca05
SRC_URI="https://github.com/autoconf-archive/autoconf-archive/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

src_compile() { :; }

src_install() {
	# GitHub snapshots do not ship the generated autotools release files,
	# but this package only needs to install the macro set and docs.
	insinto /usr/share/aclocal
	doins m4/*.m4 || die

	dodoc COPYING COPYING.EXCEPTION NEWS || die
	newdoc README.md README || die
}
