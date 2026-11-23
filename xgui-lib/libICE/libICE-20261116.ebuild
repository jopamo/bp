# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="X.Org Inter-Client Exchange library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=47da151611e7c914c5a3f69ece8c913597e3aea5
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libICE/-/archive/${SNAPSHOT}/libICE-${SNAPSHOT}.tar.bz2 -> libICE-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libice-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6 static-libs"

DEPEND="
	elibc_musl? ( app-crypto/vesk )
	xgui-lib/xtrans
	xgui-tools/xorgproto
"
RDEPEND="elibc_musl? ( app-crypto/vesk )"
BDEPEND="app-dev/pkgconf"

src_prepare() {
	qa-policy-configure
	if use elibc_musl; then
		eapply "${FILESDIR}/libICE-vesk-random.patch"
	fi
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		$(use_enable ipv6)
		--disable-docs
		--disable-specs
		--without-fop
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	qa-policy-install
}
