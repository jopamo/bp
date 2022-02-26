# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="Your basic line editor"
HOMEPAGE="https://www.gnu.org/software/ed/"
SRC_URI="mirror://gnu/ed/${P}.tar.lz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-build/texinfo
	$(unpacker_src_uri_depends)
"

_makeargs=(
  CFLAGS="${CFLAGS}"
  CPPFLAGS="${CPPFLAGS}"
  LDFLAGS="${LDFLAGS}"
)

src_configure() {
	${S}/configure --prefix="${EPREFIX}"/usr
}

src_compile() {
	emake "${_makeargs[@]}"
}
