# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit user autotools

DESCRIPTION="Robust and highly flexible tunneling application compatible with many OSes"
HOMEPAGE="https://www.strongswan.org/"
SNAPSHOT=31aedd7fbfd9d4856a5ae7085d15228ec57fb2a1
SRC_URI="https://github.com/OpenVPN/openvpn/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="plugins systemd"

DEPEND="app-compression/lzo"

src_prepare() {
	default
  	eautoreconf
}

src_configure() {
	local myconf=(
		--prefix="${EPREFIX}"/usr
    	--disable-pkcs11
    	$(use_enable plugins)
    	$(use_enable systemd)
    	--enable-x509-alt-username
	)

	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

pkg_preinst() {
	enewgroup ${PN} 394
	enewuser ${PN} 394 -1 -1 ${PN}
}
