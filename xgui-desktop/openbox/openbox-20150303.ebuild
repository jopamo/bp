# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools python-r1

DESCRIPTION="A standards compliant, fast, light-weight, extensible window manager"
HOMEPAGE="http://openbox.org/"

SNAPSHOT=9e8813e111cbe6c1088f6abbc771a29470f05fc2
SRC_URI="https://github.com/danakj/openbox/archive/${SNAPSHOT}.tar.gz -> openbox-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/openbox-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug session static-libs"

RDEPEND="
	dev-python/pyxdg[${PYTHON_USEDEP}]
	fonts/fontconfig
	lib-core/libxml2
	lib-util/glib
	xgui-lib/librsvg
	xgui-lib/libXft
	xgui-lib/libXrandr
	xgui-lib/libXt
	xgui-lib/pango
	xgui-misc/imlib2
"

DEPEND="
	${RDEPEND}
	app-build/gettext
	app-dev/pkgconf
	xgui-tools/xorgproto
	xgui-tools/xorg-server
"

PATCHES=(
	${FILESDIR}/debian-887908.patch
	${FILESDIR}/openbox-3.5.0-title-matching.patch
	${FILESDIR}/openbox-3.5.0-which-2.20.patch
	${FILESDIR}/openbox-3.5.2-gnome-session.patch
	${FILESDIR}/openbox-3.6.2-fix-out-of-bounds.patch
	${FILESDIR}/openbox-3.6.2-rounded-corners.patch
)

src_prepare() {
	sed -i '/docbook-to-man/d' "${S}"/Makefile.am || die
	sed -i \
		-e "s:-O0 -ggdb ::" \
		"${S}"/m4/openbox.m4 || die

	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-nls
		--enable-imlib2
		--enable-librsvg
		--with-x
		$(use_enable debug)
		$(use_enable session session-management)
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	insinto etc/xdg/${PN}
	doins -r ${FILESDIR}/configs/*

	insinto usr/share/themes/Mikachu/openbox-3
	doins ${FILESDIR}/themerc
}
