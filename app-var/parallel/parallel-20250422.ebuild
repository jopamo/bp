# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A shell tool for executing jobs in parallel locally or on remote machines"
HOMEPAGE="https://www.gnu.org/software/parallel/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="app-lang/perl:="
DEPEND="${RDEPEND}"

src_prepare() {
	default
	touch "will-cite"
}

src_install() {
	default

	insinto /etc/parallel
	doins will-cite
}
