# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="master"

inherit meson flag-o-matic

DESCRIPTION="implementation of the X Window System display server"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=a449d5950ed134cb227500ce8ad8c246ec04867f
SRC_URI="https://github.com/X11Libre/xserver/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/xserver-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="glamor ipv6 minimal systemd suid_wrapper udev wayland xcsecurity X"

DEPEND="
	virtual/ssl
	xgui-tools/iceauth
	xgui-lib/rgb
	xgui-tools/xauth
	xgui-lib/xbitmaps
	xgui-tools/xinit
	xgui-lib/libXau
	xgui-lib/libXdmcp
	xgui-lib/libXfont2
	xgui-lib/libdrm
	xgui-lib/libpciaccess
	xgui-lib/libxcvt
	xgui-lib/libxkbfile
	xgui-lib/libxshmfence
	xgui-lib/pixman
	xgui-lib/xtrans
	xgui-tools/xkbcomp
	xgui-misc/xkeyboard-config
	glamor? (
		xmedia-lib/libepoxy
		xgui-tools/mesa
	)
	!minimal? (
		xgui-lib/libX11
		xgui-lib/libXext
		xgui-tools/mesa
	)
	udev? ( app-core/systemd )
	systemd? (
		app-core/dbus
		app-core/systemd
	)"
BDEPEND="
	app-build/flex
	xgui-tools/xorgproto
"

PDEPEND="xgui-misc/xf86-input-libinput"

filter-flags -Wl,-z,defs -Wl,-z,now

src_configure() {
  local emesonargs=(
    $(meson_use X xorg)
		$(meson_use glamor)
		$(meson_use ipv6)
		$(meson_use suid_wrapper)
		$(meson_use systemd systemd_logind)
		$(meson_use udev)
		$(meson_use xcsecurity)
		-Ddri1=true
		-Ddri2=true
		-Ddri3=true
		-Dglx=true
		-Ddocs=false
		-Ddrm=true
		-Ddtrace=false
		-Dipv6=false
		-Dhal=false
		-Dlinux_acpi=false
		-Dlinux_apm=false
		-Dsha1=libcrypto
		-Dxkb_output_dir="${EPREFIX}/var/lib/xkb"
  )
  meson_src_configure
}

src_install() {
        meson_src_install
		dosym Xorg usr/bin/X
}
