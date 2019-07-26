# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=f858275f7f307eecba84c2f5429483f9f28007f8

inherit autotools

DESCRIPTION="A free stand-alone ini file parsing library"
HOMEPAGE="http://ndevilla.free.fr/iniparser/"
SRC_URI="https://github.com/ndevilla/iniparser/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RESTRICT="test"

PATCHES=(
	"${FILESDIR}/${PN}-3.0-autotools.patch"
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
