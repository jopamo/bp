# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=f1ca98f609f9a730b9accf24e5558a10a0b41b6c

inherit autotools

DESCRIPTION="Git is a fast, scalable, distributed revision control system"
HOMEPAGE="http://www.git-scm.com/"

SRC_URI="https://github.com/git/git/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/git-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+curl static-libs perl gitweb"

DEPEND="
	app-build/gettext
	app-net/curl
	lib-core/libpcre2
	lib-core/expat
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--with-libpcre2
		--with-curl
		--with-expat
		--without-openssl
		--without-tcltk
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	use static-libs || find "${ED}" -name "*.a" -delete || die
	use perl || rm -rf "${ED}"/usr/share/perl5 || die
	use gitweb || rm -rf "${ED}"/usr/share/gitweb || die

	insopts -m 0644
	insinto /etc
	doins "${FILESDIR}"/gitconfig
}
