# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit libtool flag-o-matic

MY_P="gc-${PV}"

DESCRIPTION="The Boehm-Demers-Weiser conservative garbage collector"
HOMEPAGE="http://www.hboehm.info/gc/ https://github.com/ivmai/bdwgc/"
SRC_URI="https://github.com/ivmai/bdwgc/releases/download/v${PV}/${MY_P}.tar.gz"

LICENSE="boehm-gc"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="cxx static-libs threads"

DEPEND="
	>=lib-dev/libatomic_ops-7.4
	dev-util/pkgconf"

S="${WORKDIR}/${MY_P}"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

src_prepare() {
	default
	elibtoolize
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--disable-docs
		--with-libatomic-ops
		$(use_enable cxx cplusplus)
		$(use_enable static-libs static)
		$(use threads || echo --disable-threads)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}
