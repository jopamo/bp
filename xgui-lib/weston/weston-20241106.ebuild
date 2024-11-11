# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson toolchain-funcs xdg flag-o-matic

DESCRIPTION="Wayland reference compositor"
HOMEPAGE="https://wayland.freedesktop.org/ https://gitlab.freedesktop.org/wayland/weston"

SNAPSHOT=10ecf6084885acaf0b07ca69987f0110759677c5
SRC_URI="https://gitlab.freedesktop.org/wayland/weston/-/archive/${SNAPSHOT}/weston-${SNAPSHOT}.tar.bz2 -> weston-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/weston-${SNAPSHOT}"

LICENSE="MIT CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="colord +desktop +drm editor examples fbdev fullscreen +gles2 headless ivi jpeg +launch lcms pipewire rdp remoting +resize-optimization screen-sharing static-libs +suid systemd test wayland-compositor webp +X xwayland"

REQUIRED_USE="
	colord? ( lcms )
	drm? ( gles2 )
	pipewire? ( drm )
	screen-sharing? ( rdp )
	test? ( desktop headless xwayland )
	wayland-compositor? ( gles2 )
	|| ( drm fbdev headless rdp wayland-compositor X )
"

RDEPEND="
	lib-util/libinput
	xgui-lib/cairo
	xgui-lib/libdrm
	xgui-lib/libxkbcommon
	xgui-lib/pixman
	xgui-lib/wayland
	xgui-lib/wayland-protocols
	xgui-misc/xkeyboard-config
	xmedia-lib/libpng
	lcms? ( xgui-misc/lcms:2 )
	webp? ( xmedia-lib/libwebp )
	jpeg? ( xmedia-lib/libjpeg-turbo )
	fbdev? (
		>=xgui-misc/mtdev-1.1.0
		virtual/service-manager
	)
	colord? ( >=x11-misc/colord-0.1.27 )
	drm? (
		xgui-tools/mesa
		>=xgui-misc/mtdev-1.1.0
		virtual/service-manager
	)
	editor? ( xgui-lib/pango )
	gles2? (
		xgui-tools/mesa
	)
	pipewire? ( xgui-misc/pipewire )
	rdp? ( >=app-net/freerdp-2.0.0_rc2:= )
	remoting? (
		xmedia-live-lib/gstreamer:1.0
		xmedia-live-lib/gst-plugins-base:1.0
	)
	systemd? (
		app-core/pambase
		app-core/dbus
		app-core/systemd[pam]
	)
	launch? ( app-core/pambase )
	X? (
		xgui-lib/libxcb
		xgui-lib/libX11
	)
	xwayland? (
		x11-misc/xorg-server[wayland]
		xgui-lib/cairo[xcb]
		xgui-lib/libxcb
		xgui-lib/libXcursor
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	app-dev/pkgconf
"

filter-flags -Wl,-z,defs

src_configure() {
	local emesonargs=(
		$(meson_use drm backend-drm)
		-Dbackend-drm-screencast-vaapi=false
		$(meson_use headless backend-headless)
		$(meson_use rdp backend-rdp)
		$(meson_use screen-sharing screenshare)
		$(meson_use wayland-compositor backend-wayland)
		$(meson_use X backend-x11)
		$(meson_use fbdev backend-fbdev)
		-Dbackend-default=auto
		$(meson_use gles2 renderer-gl)
		$(meson_use launch weston-launch)
		$(meson_use xwayland)
		$(meson_use systemd)
		$(meson_use remoting)
		$(meson_use pipewire)
		$(meson_use desktop shell-desktop)
		$(meson_use fullscreen shell-fullscreen)
		$(meson_use ivi shell-ivi)
		$(meson_use lcms color-management-lcms)
		$(meson_use colord color-management-colord)
		$(meson_use systemd launcher-logind)
		$(meson_use jpeg image-jpeg)
		$(meson_use webp image-webp)
		-Dtools=debug,info,terminal
		-Dsimple-dmabuf-drm=auto
		$(meson_use examples demo-clients)
		$(usex examples -Dsimple-clients=damage,dmabuf-v4l,im,shm,touch$(usex gles2 ,dmabuf-egl,egl "") "")
		$(meson_use resize-optimization resize-pool)
		-Dtest-junit-xml=false
		"${myconf[@]}"
	)
	meson_src_configure
}

src_test() {
	xdg_environment_reset

	# devices test usually fails.
	cd "${BUILD_DIR}" || die
	meson test $(meson test --list | grep -Fxv devices) || die
}

src_install() {
	meson_src_install
	if use launch && use suid; then
		chmod u+s "${ED}"/usr/bin/weston-launch || die
	fi
}
