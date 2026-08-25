# Distributed under the terms of the GNU General Public License v2

#BRANCH_NAME="maint-$(ver_cut 1).0"

inherit meson flag-o-matic nvidia-musl-startup

DESCRIPTION="implementation of the X Window System display server"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=1b75135c09eea67d7ed9a51ebfa0cb7716e0a32d
SRC_URI="https://github.com/X11Libre/xserver/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/xserver-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="glamor ipv6 minimal nvidia systemd udev wayland xcsecurity +xephyr +xvfb X"
REQUIRED_USE="
	nvidia? ( X )
	${NVIDIA_MUSL_STARTUP_REQUIRED_USE}
"

DEPEND="
	virtual/ssl
	xgui-lib/libdrm
	xgui-lib/libpciaccess
	xgui-lib/libXau
	xgui-lib/libxcvt
	xgui-lib/libXdmcp
	xgui-lib/libXfont2
	xgui-lib/libxkbfile
	xgui-lib/libxshmfence
	xgui-lib/pixman
	xgui-lib/rgb
	xgui-lib/xbitmaps
	xgui-lib/xcb-util
	xgui-lib/xtrans
	xgui-tools/xkeyboard-config
	xgui-tools/iceauth
	xgui-tools/xauth
	xgui-tools/xinit
	xgui-tools/xkbcomp
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
		virtual/dbus
		app-core/systemd
	)
	${NVIDIA_MUSL_STARTUP_DEPEND}
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-dev/pkgconf
	app-build/flex
	xgui-tools/xorgproto
"

PDEPEND="xgui-tools/xf86-input-libinput"

src_prepare() {
	default

	eapply "${FILESDIR}"/${PN}-backtrace-execinfo.patch
	eapply "${FILESDIR}"/${PN}-nvidia-musl-startup.patch

	sed -i -E \
		'/^[[:space:]]*static[[:space:]]+inline[[:space:]]+int[[:space:]]+pci_device_is_boot_display[[:space:]]*\(/,/^[[:space:]]*}\s*$/d' \
		hw/xfree86/common/xf86_pci_priv.h || die
}

src_configure() {
  # avoid forcing immediate binding which can break nvidia GL stubs at link time
  filter-flags -Wl,-z,defs -Wl,-z,now

  local nvidia_musl_startup=disabled
  if use nvidia && use elibc_musl; then
    nvidia_musl_startup=enabled
  fi

  local emesonargs=(
    # core servers and backends
    $(meson_use X xorg)          # build the xorg server
    -Dsuid_wrapper=false         # no legacy privilege or launch wrapper
    $(meson_use xvfb)            # virtual framebuffer server
    $(meson_use xephyr)          # no nested xephyr
    -Dxnest=false                # no legacy Xnest
    -Dxwin=false                 # no cygwin backend
    -Dxquartz=false              # no macOS quartz
    -Dxpbproxy=false             # no proxy

    # rendering and dri paths
    -Dglx=true                   # GLX needed for nvidia proprietary
    -Ddri1=false                 # dri1 is obsolete
    -Ddri2=true                  # dri2 required by nvidia GLX
    -Ddri3=true                  # dri3 for modesetting and modern stacks
    -Ddrm=true                   # enable drm hooks even if using nvidia

    # device and session management
    $(meson_use udev)            # input hotplug via libudev
    -Dsystemd_logind=true        # vt/session handoff through logind
    -Dsystemd_notify=true        # sd_notify integration
    -Dvgahw=auto                 # vgahw module auto
    -Dpciaccess=true             # libpciaccess for probing

    # networking and auth listeners
    $(meson_use ipv6)
    -Dlisten_tcp=false           # disable tcp listener for local-only setups
    -Dlisten_unix=true           # enable unix socket
    -Dlisten_local=true          # create abstract local socket

    # security and extensions
    $(meson_use xcsecurity)      # XACE/XC-Security
    -Ddpms=true                  # display power management
    -Dscreensaver=true           # MIT-SCREEN-SAVER
    -Dxres=true                  # X-Resource extension
    -Dxinerama=true              # Xinerama protocol for multihead
    -Dxv=true                    # XVideo extension
    -Ddga=auto                   # DGA if available
    -Dmitshm=auto                # MIT-SHM
    -Dagp=false                  # agp helper not needed with modern stacks

    # linux power backends
    -Dlinux_apm=false            # legacy /proc/apm backend, safe to disable
    -Dlinux_acpi=false           # legacy /proc/acpi hooks, safe to disable

    # crypto and misc
    -Dsha1=libcrypto             # use openssl for sha1
    -Dlibunwind=false            # keep unwinder off unless debugging
    -Dlegacy_nvidia_340x=false   # do not export obsolete 340xx driver entrypoints
    -Dnvidia_musl_startup="${nvidia_musl_startup}"
    #-Dlegacy_nvidia_padding=false # keep default pixmap padding; set true only for very old nvidia blobs

    # features we explicitly keep off
    -Dxdmcp=false                # no xdmcp
    -Dxdm-auth-1=false           # no old auth proto
    -Dhal=false                  # no hal input stack

    # build products and paths
    -Dtests=false
    -Ddocs=false
    -Ddevel-docs=false
    -Ddocs-pdf=false
    -Dxkb_output_dir="${EPREFIX}/var/lib/xkb"
  )

  meson_src_configure
}

src_install() {
        meson_src_install
		dosym -r /usr/bin/Xorg /usr/bin/X

	nvidia_musl_startup_verify /usr/bin/Xorg
}
