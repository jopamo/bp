# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic multilib-minimal

DESCRIPTION="General purpose crypto library based on the code used in GnuPG"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="mirror://gnupg/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1 MIT"
SLOT="0/20"
KEYWORDS="amd64 arm64 x86"
IUSE="o-flag-munging static-libs"

RDEPEND=">=lib-dev/libgpg-error-1.25[${MULTILIB_USEDEP}]"

DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-1.6.1-uscore.patch
	"${FILESDIR}"/${PN}-multilib-syspath.patch
)

MULTILIB_CHOST_TOOLS=(
	/usr/bin/libgcrypt-config
)

src_prepare() {
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
		--disable-dependency-tracking
		--enable-noexecstack
		$(use_enable o-flag-munging O-flag-munging)
		$(use_enable static-libs static)
		--without-capabilities
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

multilib_src_install() {
	emake DESTDIR="${D}" install
}

multilib_src_install_all() {
	default
	find "${ED}" -name "*.la" -delete || die
}
