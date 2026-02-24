# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools dot-a

DESCRIPTION="Stream-oriented XML parser library"
HOMEPAGE="https://github.com/libexpat/libexpat"
SNAPSHOT=b862e39c3ac93dba7b634aa45a06d632af364619
SRC_URI="https://github.com/libexpat/libexpat/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/libexpat-${SNAPSHOT}/expat

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	use static-libs && lto-guarantee-fat

	default
	eautoreconf

	# Remove autoreconf, it's already completed
	sed -i '/^autoreconf/d' "${S}"/buildconf.sh || die
	"${S}"/buildconf.sh
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		--without-docbook
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs && strip-lto-bytecode
}
