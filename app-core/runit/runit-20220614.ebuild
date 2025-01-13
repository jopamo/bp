# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic

DESCRIPTION="A UNIX init scheme with service supervision"
HOMEPAGE="http://smarden.org/runit/"

SNAPSHOT=2b8000f1ebd07fd68ee0e3c32737d97bcd1687fb
SRC_URI="https://github.com/void-linux/runit/archive/${SNAPSHOT}.tar.gz -> runit-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/runit-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

filter-flags -flto\=\*

src_prepare() {
	default

	sed -e 's,sbin/runit,usr/sbin/runit,g' -i runit.h

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
