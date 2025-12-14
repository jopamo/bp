# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

DESCRIPTION="Proton Mail Bridge – encrypts/decrypts mail as it leaves/enters your system (pre-built binary)"
HOMEPAGE="https://proton.me/mail/bridge"
SRC_URI="https://proton.me/download/bridge/protonmail-bridge_${PV}-1_amd64.deb"
S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
RESTRICT="mirror strip"          # upstream binary already stripped

RDEPEND="
      xgui-lib/xcb-util-cursor
      xmedia-lib/libglvnd
      dev-libs/glib:2
      app-crypto/pass
"

# Everything below usr/lib/protonmail is upstream-bundled → skip QA
QA_PREBUILT="
  usr/lib/protonmail/bridge/*
"

src_unpack() {
  unpacker_src_unpack          # extracts data.tar.* into ${WORKDIR}/usr/…
}

src_install() {
  # 1. install the tree exactly as shipped
  cp -a "${WORKDIR}"/usr "${ED}"/ || die

  # 2. Provide a shorter CLI symlink (many how-tos call 'proton-bridge')
  dosym -r /usr/lib/protonmail/bridge/proton-bridge /usr/bin/proton-bridge

  # 3. docs & desktop/icons are already under /usr/share → nothing to do
}

pkg_postinst() {
  xdg_desktop_database_update
  xdg_icon_cache_update
}

pkg_postrm() {
  xdg_desktop_database_update
  xdg_icon_cache_update
}
