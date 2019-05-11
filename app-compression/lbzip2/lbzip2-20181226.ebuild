# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Parallel bzip2 utility"
HOMEPAGE="https://github.com/kjn/lbzip2/"
SRC_URI="https://1g4.org/files/lbzip2-${PV}.tar.xz"

LICENSE="GPL-3"
SLOT="0/1"
KEYWORDS="amd64 arm64"

src_install() {
	default
	dosym ${PN} usr/bin/bzip2
	dosym lbunzip2 usr/bin/bunzip2
	dosym lbzcat usr/bin/bzcat
}
