# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="XSLT libraries and tools"
HOMEPAGE="http://www.xmlsoft.org/"
SNAPSHOT=24ee4028314847b061c2a2a50919b36736828bea
SRC_URI="https://gitlab.gnome.org/GNOME/libxslt/-/archive/${SNAPSHOT}/libxslt-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxslt-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="crypt debug static-libs"

DEPEND="
	lib-core/libxml2
	crypt?  ( app-crypto/vesk )
"

PATCHES=( "${FILESDIR}/exslt-provider-capabilities.patch" )

src_prepare() {
	qa-policy-configure
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		$(use_with crypt crypto)
		$(use_with debug)
		--without-python
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_install() {
	default
	qa-policy-install
}
