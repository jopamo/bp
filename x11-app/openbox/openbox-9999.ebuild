# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PYTHON_COMPAT=( python3_{6,7,8} )

inherit multilib-minimal autotools python-r1 eutils git-r3

DESCRIPTION="A standards compliant, fast, light-weight, extensible window manager"
HOMEPAGE="http://openbox.org/"

EGIT_REPO_URI="https://github.com/danakj/openbox.git"

KEYWORDS="amd64 arm64 x86"

LICENSE="GPL-2"
SLOT=0
IUSE="debug nls session static-libs"

RDEPEND="lib-dev/glib:2
	>=lib-dev/libxml2-2.0
	>=lib-media/fontconfig-2
	x11-libs/libXft
	x11-libs/libXrandr
	x11-libs/libXt
	x11-libs/pango
	lib-media/imlib2
	gui-lib/librsvg
	dev-python/pyxdg[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	x11/xorgproto
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

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
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
