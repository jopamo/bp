# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Provides a standard configuration setup for installing PKCS#11"
HOMEPAGE="https://p11-glue.freedesktop.org/p11-kit.html https://github.com/p11-glue/p11-kit"
SRC_URI="https://github.com/p11-glue/${PN}/releases/download/${PV}/${P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug +libffi"

DEPEND="libffi? ( >=lib-dev/libffi-3.0.0 )"
BDEPEND="dev-util/pkgconf"

pkg_setup() {
	# disable unsafe tests, bug#502088
	export FAKED_MODE=1
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--without-libtasn1
		$(use_enable debug)
		$(use_with libffi)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
