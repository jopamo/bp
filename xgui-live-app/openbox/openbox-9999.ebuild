# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools python-r1 git-r3

DESCRIPTION="A standards compliant, fast, light-weight, extensible window manager"
HOMEPAGE="http://openbox.org/"
EGIT_REPO_URI="https://github.com/danakj/openbox.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug nls session static-libs"

RDEPEND="lib-dev/glib:2
	>=lib-core/libxml2-2.0
	>=xmedia-live-lib/fontconfig-2
	x11-live-lib/libXft
	x11-live-lib/libXrandr
	x11-live-lib/libXt
	x11-live-lib/pango
	xmedia-live-lib/imlib2
	xgui-live-lib/librsvg
	dev-python/pyxdg[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconf
	x11-live-misc/xorgproto
	xgui-misc/xorg-server
"

PATCHES=(
	${FILESDIR}/openbox-3.5.0-title-matching.patch
	${FILESDIR}/openbox-3.5.0-which-2.20.patch
	${FILESDIR}/openbox-3.5.2-gnome-session.patch
	${FILESDIR}/openbox-3.6.2-fix-out-of-bounds.patch
	${FILESDIR}/openbox-3.6.2-rounded-corners.patch
)

src_prepare() {
	2to3 -w ${S}/data/autostart/openbox-xdg-autostart || die
	sed 's/python/python3/' -i ${S}/data/autostart/openbox-xdg-autostart || die
	sed -i '/docbook-to-man/d' "${S}"/Makefile.am || die
	sed -i \
		-e "s:-O0 -ggdb ::" \
		"${S}"/m4/openbox.m4 || die

	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable debug)
		$(use_enable static-libs static)
		$(use_enable nls)
		--enable-imlib2
		--enable-librsvg
		$(use_enable session session-management)
		--with-x
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	insinto etc/xdg/${PN}
	doins -r ${FILESDIR}/configs/*
}
