# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="musl headers compat"

LICENSE="GPL"
SLOT="0"
KEYWORDS="arm64 amd64"

S="${WORKDIR}"

src_install() {
	insinto usr/include/sys/
	doins "${FILESDIR}"/cdefs.h
	doins "${FILESDIR}"/queue.h
	doins "${FILESDIR}"/tree.h
}
