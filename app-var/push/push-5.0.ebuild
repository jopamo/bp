# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A POSIX shell function to treat a variable like an array, quoting args"
HOMEPAGE="https://github.com/vaeth/push/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

src_unpack() {
	mkdir ${S}
}

src_install() {
	dobin "${FILESDIR}"/push.sh
}
