# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Provides a standard configuration setup for installing PKCS#11"
HOMEPAGE="https://p11-glue.freedesktop.org/p11-kit.html https://github.com/p11-glue/p11-kit"
SRC_URI="https://github.com/p11-glue/${PN}/releases/download/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug +libffi"

RDEPEND="libffi? ( >=lib-dev/libffi-3.0.0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconf"

pkg_setup() {
	# disable unsafe tests, bug#502088
	export FAKED_MODE=1
}

src_configure() {
	ECONF_SOURCE="${S}" econf \
		--without-libtasn1	\
		$(use_enable debug) \
		$(use_with libffi)
}

src_install() {
	default
	find "${ED}" -name "*.la" -delete || die
}
