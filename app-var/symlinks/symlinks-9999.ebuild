# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Scans for and fixes broken or messy symlinks"
HOMEPAGE="http://www.ibiblio.org/pub/linux/utils/file/"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/jopamo/symlinks"
	inherit git-r3
else
	SNAPSHOT=
	SRC_URI="https://github.com/jopamo/symlinks/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="symlinks"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

src_prepare() {
	default
	use static && append-flags -static
	append-lfs-flags
	sed 's:-O2::g' -i Makefile || die
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CPPFLAGS} ${CFLAGS} ${LDFLAGS}"
}

src_install() {
	dobin "${PN}"
	doman "${PN}.8"
}
