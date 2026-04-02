# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="Stream-oriented XML parser library"
HOMEPAGE="https://github.com/libexpat/libexpat"
SNAPSHOT=fa1f0cd8f959190866baf1e7ad1aa6412927eb19
SRC_URI="https://github.com/libexpat/libexpat/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/libexpat-${SNAPSHOT}/expat

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	qa-policy-configure
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
	qa-policy-install
}
