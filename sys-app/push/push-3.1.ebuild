# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A POSIX shell function to treat a variable like an array, quoting args"
HOMEPAGE="https://github.com/vaeth/push/"
SRC_URI="https://github.com/vaeth/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

src_install() {
	emake DESTDIR="${ED}" PREFIX="${EPREFIX}"/usr install
}
