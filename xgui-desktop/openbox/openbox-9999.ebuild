# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools python-r1

DESCRIPTION="A standards compliant, fast, light-weight, extensible window manager"
HOMEPAGE="http://openbox.org/"

if [[ ${PV} != 9999 ]]; then
	SNAPSHOT=0f1a9f19cab56ef67ce0cf176e49466fbe65605d
	SRC_URI="https://github.com/jopamo/ob/archive/${SNAPSHOT}.tar.gz -> openbox-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/openbox-${SNAPSHOT}"
else
	WANT_LIBTOOL=none
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jopamo/ob.git"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug +session static-libs"

RDEPEND="
	dev-python/pyxdg[${PYTHON_USEDEP}]
	fonts/fontconfig
	lib-core/libxml2
	lib-util/glib
	xgui-lib/libXft
	xgui-lib/libXrandr
	xgui-lib/libXt
	xgui-lib/librsvg
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

	# for xdg
	cat > "${T}"/99${PN} <<- EOF || die
		XDG_CURRENT_DESKTOP=LXQt
	EOF
	doenvd "${T}"/99${PN}
}
