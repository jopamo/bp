# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="X.509 and CMS (PKCS#7) library"
HOMEPAGE="http://www.gnupg.org/related_software/libksba"
SRC_URI="mirror://gnupg/libksba/${P}.tar.bz2"

LICENSE="LGPL-3+ GPL-2+ GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="static-libs"

RDEPEND=">=lib-dev/libgpg-error-1.8"
DEPEND="${RDEPEND}"

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	find "${ED}" -name "*.la" -delete || die
}
