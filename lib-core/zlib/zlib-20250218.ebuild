# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Standard (de)compression library"
HOMEPAGE="https://zlib.net/"

SNAPSHOT=5a82f71ed1dfc0bec044d9702463dbdf84ea3b71
SRC_URI="https://github.com/madler/zlib/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/zlib-${SNAPSHOT}

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="minizip static-libs"

src_prepare() {
	sed -i '/^  elif test -z.*$/,/^  fi$/c\  fi' configure

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

		insinto /usr/include/minizip
		doins contrib/minizip/*.h

		rm -f "${ED}"/usr/lib/libminizip.la || die
	fi

}
