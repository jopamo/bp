# Distributed under the terms of the GNU General Public License v2

inherit autotools flag-o-matic qa-policy

DESCRIPTION="Shared library for libmediainfo and mediainfo"
HOMEPAGE="https://github.com/MediaArea/ZenLib"
SNAPSHOT=45c8e6594f9f263a010d3f592b56f39b8297785a
SRC_URI="https://github.com/MediaArea/ZenLib/archive/${SNAPSHOT}.tar.gz -> ZenLib-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/ZenLib-${SNAPSHOT}/Project/GNU/Library"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="keep-la static-libs"

DEPEND="app-dev/pkgconf"

src_prepare() {
	qa-policy-configure
	filter-flags -Wl,-z,defs -flto*
	default
	sed -i 's:-O2::' configure.ac || die
	eautoreconf
}

src_configure() {
	local myconf=(
		--enable-unicode
		--enable-shared
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	qa-policy-install

	insinto /usr/lib/pkgconfig
	doins libzen.pc

	if ! use keep-la; then
		find "${ED}" -name '*.la' -delete || die
	fi
}
