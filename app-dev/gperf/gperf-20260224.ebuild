# Distributed under the terms of the GNU General Public License v2

inherit autotools gl
SNAPSHOT=38ddb4c4e4c1f349af5a8c5c534271c119c0f5ed

DESCRIPTION="A perfect hash function generator"
HOMEPAGE="https://www.gnu.org/software/gperf/"

SRC_URI="https://github.com/1g4-mirror/gperf/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

SRC_URI+=" ${GL_SRC_URI}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	gl_stage_gnulib

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
