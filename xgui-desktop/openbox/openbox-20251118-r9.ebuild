# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools python-r1 flag-o-matic

DESCRIPTION="A standards compliant, fast, light-weight, extensible window manager"
HOMEPAGE="http://openbox.org/"

if [[ ${PV} != 9999 ]]; then
	SNAPSHOT=dac6e2f6f8f2e0c5586a9e19f18508a03db639cb
	SRC_URI="https://github.com/jopamo/openbox/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/${PN}-${SNAPSHOT}"
else
	WANT_LIBTOOL=none
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jopamo/ob.git"
fi

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="amd64 arm64"

IUSE="asan debug session static-libs"

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
	xgui-lib/imlib2
"

DEPEND="
	${RDEPEND}
	app-build/gettext
	app-dev/pkgconf
	xgui-tools/xorgproto
	xgui-tools/xorg-server
"

src_prepare() {
	append-flags -Wno-implicit-function-declaration

	sed -i '/docbook-to-man/d' "${S}"/Makefile.am || die
	sed -i \
		-e "s:-O0 -ggdb ::" \
		"${S}"/m4/openbox.m4 || die

	default
	eautoreconf
}

src_configure() {
	if use asan; then
		: "${CC:=clang}"
		: "${CXX:=clang++}"
		export CC CXX

		strip-flags
		filter-clang

		filter-flags -O0 -O1 -O2 -O3 -Os -Ofast -Og
		filter-flags -g -ggdb -ggdb3

		append-flags -O1 -g -fno-omit-frame-pointer
	fi

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
		XDG_CURRENT_DESKTOP=XFCE
	EOF
	doenvd "${T}"/99${PN}
}
