# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic libtool

DESCRIPTION="C library for executing name service queries asynchronously"
HOMEPAGE="http://0pointer.de/lennart/projects/libasyncns/"
SRC_URI="http://0pointer.de/lennart/projects/libasyncns/${P}.tar.gz"

SLOT="0"

LICENSE="LGPL-2.1"
KEYWORDS="amd64 arm64"

IUSE="doc debug"

DEPEND="doc? ( app-text/doxygen )"

src_prepare() {
	# fix libdir in pkgconfig file
	eapply "${FILESDIR}/${P}-libdir.patch"
	# fix configure check for res_query
	eapply "${FILESDIR}/${P}-configure-res_query.patch"
	eautoreconf
	default
}

src_configure() {
	# libasyncns uses assert()
	use debug || append-cppflags -DNDEBUG

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
		--htmldir="${EPREFIX}"/usr/share/doc/${PF}/html
		--disable-dependency-tracking
		--disable-lynx
		--disable-static
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	find "${D}" -name '*.la' -delete
}
