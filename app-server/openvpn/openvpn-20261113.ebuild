# Distributed under the terms of the GNU General Public License v2

inherit user autotools flag-o-matic

DESCRIPTION="Robust and highly flexible tunneling application compatible with many OSes"
HOMEPAGE="https://openvpn.net/"
SNAPSHOT=9e9f76c872fc67fe5ed9a11853509cf965c30d79
SRC_URI="https://github.com/OpenVPN/openvpn/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="plugins systemd test"
RESTRICT="!test? ( test )"

RDEPEND="
	app-compression/lzo
	virtual/ssl
"
DEPEND="${RDEPEND}"
BDEPEND="test? ( lib-dev/cmocka )"

PATCHES=( "${FILESDIR}/crypto-compat-feature-checks.patch" )

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
		$(use_enable test unit-tests)
	)

	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_test() {
	# LTO resolves calls before the test linker's --wrap can intercept them.
	filter-lto
	emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" check
}

pkg_preinst() {
	enewgroup ${PN} 394
	enewuser ${PN} 394 -1 -1 ${PN}
}
