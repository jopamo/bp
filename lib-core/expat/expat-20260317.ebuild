# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="Stream-oriented XML parser library"
HOMEPAGE="https://github.com/libexpat/libexpat"
SNAPSHOT=f31adfd584b7f6c50bbf4d22eb928538ffc9145a
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
