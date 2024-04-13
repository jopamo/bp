# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic linux-info xdg

MY_P=makemkv-oss-${PV}
MY_PB=makemkv-bin-${PV}

DESCRIPTION="Tool for ripping and streaming Blu-ray, HD-DVD and DVD discs"
HOMEPAGE="http://www.makemkv.com/"
SRC_URI="http://www.makemkv.com/download/${MY_P}.tar.gz
	http://www.makemkv.com/download/${MY_PB}.tar.gz"

LICENSE="GPL-2 LGPL-2.1 MPL-1.1 MakeMKV-EULA openssl"
SLOT="0"
KEYWORDS="amd64"

IUSE="+gui +java"

RESTRICT="mirror"

QA_PREBUILT="usr/bin/makemkvcon usr/bin/mmdtsdec"

DEPEND="
	dev-libs/expat
	lib-core/glibc
	lib-core/zlib
	virtual/ssl
	xmedia-app/ffmpeg
	gui? ( xgui-lib/qtbase )
"
RDEPEND="
	${DEPEND}
	app-net/wget
	java? ( bin/openjdk8 )
"

CONFIG_CHECK="~CHR_DEV_SG"
S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}"/${PN}-path.patch
)

src_prepare() {
	filter-flags -fpic -fpie

	default

	if ! use java; then
		rm -v "${WORKDIR}/${MY_PB}"/src/share/blues.* || die
	fi
}

src_configure() {
	local myconf=(
		--enable-debug
		--disable-noec
		$(use_enable gui)
		$(use_enable gui qt5)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_install() {
	default

	# add missing symlinks for QA
	dosym libdriveio.so.0 /usr/lib/libdriveio.so.0.${PV}
	dosym libdriveio.so.0 /usr/lib/libdriveio.so
	dosym libmakemkv.so.1 /usr/lib/libmakemkv.so.1.${PV}
	dosym libmakemkv.so.1 /usr/lib/libmakemkv.so
	dosym libmmbd.so.0    /usr/lib/libmmbd.so
	dosym libmmbd.so.0    /usr/lib/libmmbd.so.0.${PV}

	cd "${WORKDIR}"/${MY_PB} || die

	# install prebuilt bin
	dobin bin/"${ARCH}"/makemkvcon

	# additional tool is actually part of makemkvcon
	dosym makemkvcon /usr/bin/sdftool

	# install profiles and locales
	insinto /usr/share/MakeMKV
	doins src/share/*

	# install unofficial man page
	doman "${FILESDIR}"/makemkvcon.1
}
