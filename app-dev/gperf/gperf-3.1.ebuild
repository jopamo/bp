# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A perfect hash function generator"
HOMEPAGE="https://www.gnu.org/software/gperf/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	sed -i \
		-e "/^CPPFLAGS /s:=:+=:" \
		*/Makefile.in || die

	default
	eapply "${FILESDIR}"/gperf-3.1-strncmp-decl-mismatch.patch
	eapply "${FILESDIR}"/gperf-3.1-clang-16-wregister.patch

}

src_configure() {
	default
	sed -i '/doc/d' Makefile || die
}
