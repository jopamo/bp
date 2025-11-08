# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson python-r1

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

IUSE="debug +session static-libs
      startup_notification
      +xcursor
      +imlib2
      +librsvg
      +xkb
      +xrandr
      xinerama
      xshape
      xsync
      +session_management
      rendertest"

RDEPEND="
	dev-python/pyxdg[${PYTHON_USEDEP}]
	fonts/fontconfig
	lib-core/libxml2
	lib-util/glib
	xgui-lib/libXft
	xgui-lib/libXt
	xgui-lib/pango

	startup_notification? ( xgui-lib/libstartup-notification )
	xcursor? ( xgui-lib/libXcursor )
	imlib2? ( xgui-lib/imlib2 )
	librsvg? ( xgui-lib/librsvg )

	xkb? ( xgui-lib/libxkbfile )

	xrandr? ( xgui-lib/libXrandr )
	xinerama? ( xgui-lib/libXinerama )
	xshape? ( xgui-lib/libXext )
	xsync? ( xgui-lib/libXext )

	session_management? (
		xgui-lib/libSM
		xgui-lib/libICE
	)
"

DEPEND="
	${RDEPEND}
	app-build/gettext
	app-dev/pkgconf
	xgui-tools/xorgproto
	xgui-tools/xorg-server
"

src_configure() {
  local meson_args=(
    -Dstartup_notification=$(usex startup_notification enabled disabled)
    -Dxcursor=$(usex xcursor enabled disabled)
    -Dimlib2=$(usex imlib2 enabled disabled)
    -Dlibrsvg=$(usex librsvg enabled disabled)
    -Dxkb=$(usex xkb enabled disabled)
    -Dxrandr=$(usex xrandr enabled disabled)
    -Dxinerama=$(usex xinerama enabled disabled)
    -Dxshape=$(usex xshape enabled disabled)
    -Dxsync=$(usex xsync enabled disabled)
    -Dsession_management=$(usex session_management enabled disabled)
    -Drendertest=false
    -Ddefault_theme=Clearlooks
  )

  meson_src_configure "${meson_args[@]}" || die "meson configure failed"
}
