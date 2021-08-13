# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs flag-o-matic

DESCRIPTION="A UNIX init scheme with service supervision"
HOMEPAGE="http://smarden.org/runit/"
EGIT_REPO_URI="https://github.com/void-linux/runit.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

S=${S}/src

filter-flags -flto\=\*

src_prepare() {
	default

	# we either build everything or nothing static
	sed -i -e 's:-static: :' Makefile
}

src_configure() {
	use static && append-ldflags -static

	echo "$(tc-getCC) ${CFLAGS}"  > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
}

src_install() {
	local f
	for f in chpst runit runit-init runsv runsvchdir runsvdir \
		sv svlogd utmpset; do
		dobin $f
	done
}
