# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Standard (de)compression library"
HOMEPAGE="https://zlib.net/"

SNAPSHOT=ef24c4c7502169f016dcd2a26923dbaf3216748c
SRC_URI="https://github.com/madler/zlib/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="minizip static-libs"

src_prepare() {
	default

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

	if use minizip ; then
		emake -C contrib/minizip install DESTDIR="${D}"

		insinto /usr/include/minizip
		doins contrib/minizip/*.h
	fi
}
