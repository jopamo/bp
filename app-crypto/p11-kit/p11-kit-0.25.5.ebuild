# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Provides a standard configuration setup for installing PKCS#11"
HOMEPAGE="https://p11-glue.freedesktop.org/p11-kit.html https://github.com/p11-glue/p11-kit"
SRC_URI="https://github.com/p11-glue/${PN}/releases/download/${PV}/${P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug libffi"

DEPEND="libffi? ( lib-core/libffi )"

pkg_setup() {
	# disable unsafe tests, bug#502088
	export FAKED_MODE=1
}

src_configure() {
	local myconf=(
		--without-libtasn1
		$(use_enable debug)
		$(use_with libffi)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
