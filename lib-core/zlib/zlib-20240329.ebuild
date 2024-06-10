# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Standard (de)compression library"
HOMEPAGE="https://zlib.net/"

SNAPSHOT=0f51fb4933fc9ce18199cb2554dacea8033e7fd3
SRC_URI="https://github.com/madler/zlib/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="minizip static-libs"

src_prepare() {
	default

	#ldconfig is not used
	sed -i 's/ldconfig/false/g' configure

	if use minizip ; then
		cd contrib/minizip || die
		eautoreconf
	fi
}

src_configure() {
	local myconf=(
		--shared
		--prefix="${EPREFIX}/usr"
		--libdir="${EPREFIX}/usr/lib"
	)
	ECONF_SOURCE=${S} ./configure "${myconf[@]}"

	if use minizip ; then
		local minizipdir="contrib/minizip"

		cd ${minizipdir} || die
		ECONF_SOURCE="${S}/${minizipdir}" econf $(use_enable static-libs static)
	fi
}

src_install() {
	default
	use static-libs || rm -f "${ED}"/usr/lib/libz.{a,la}

	if use minizip ; then
		emake -C contrib/minizip install DESTDIR="${D}"

		rm -f "${ED}"/usr/lib/libminizip.la || die
	fi
}
