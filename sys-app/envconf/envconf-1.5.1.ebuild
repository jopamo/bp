# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="compiler options, workaround for now"
HOMEPAGE="https://1g4.org"
SRC_URI="https://1g4.org/files/${P}.tar.xz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
S="${WORKDIR}"

src_install() {
	mkdir -p "${ED}"/etc
	mv "${S}"/portage "${ED}"/etc/portage
}
