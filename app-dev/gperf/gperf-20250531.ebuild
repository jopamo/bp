# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

SNAPSHOT=4939b6b6158332d35eb30a7f1f2b7f15450b9893

DESCRIPTION="A perfect hash function generator"
HOMEPAGE="https://www.gnu.org/software/gperf/"

SRC_URI="https://github.com/1g4-mirror/gperf/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	rm -rf gnulib
	cp -r "${EROOT}"/usr/share/gnulib gnulib

	sed -i \
		-e "/^CPPFLAGS /s:=:+=:" \
		*/Makefile.in || die

	./autogen.sh
	eautoreconf
	default
}


src_configure() {
	default
	sed -i '/doc/d' Makefile || die
}

