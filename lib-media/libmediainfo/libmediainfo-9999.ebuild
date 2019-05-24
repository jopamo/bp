# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic git-r3

MY_PN="MediaInfo"
DESCRIPTION="MediaInfo libraries"
HOMEPAGE="https://mediaarea.net/mediainfo/ https://github.com/MediaArea/MediaInfoLib"
EGIT_REPO_URI="https://github.com/MediaArea/MediaInfoLib.git"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="curl doc static-libs"

RDEPEND="lib-sys/zlib
	lib-dev/tinyxml2:=
	>=lib-media/libzen-0.4.37[static-libs=]"

DEPEND="${RDEPEND}
	dev-util/pkgconf"

RESTRICT="test"

S=${WORKDIR}/${P}/Project/GNU/Library

src_prepare() {
	eapply_user
	sed -i 's:-O2::' configure.ac || die
	append-cppflags -DMEDIAINFO_LIBMMS_DESCRIBE_SUPPORT=0
	eautoreconf
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--enable-shared
		$(use_enable static-libs static)
		--with-libtinyxml2
		$(use_with curl libcurl)
		$(use_enable static-libs static)
		$(use_enable static-libs staticlibs)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	edos2unix ${PN}.pc
	insinto /usr/lib64/pkgconfig
	doins ${PN}.pc

	for x in ./ Archive Audio Duplicate Export Image Multiple Reader Tag Text Video; do
		insinto /usr/include/MediaInfo/${x}
		doins "${WORKDIR}"/${P}/Source/MediaInfo/${x}/*.h
	done

	insinto /usr/include/MediaInfoDLL
	doins "${WORKDIR}"/${P}/Source/MediaInfoDLL/*.h
}
