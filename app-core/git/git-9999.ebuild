# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Git is a fast, scalable, distributed revision control system"
HOMEPAGE="http://www.git-scm.com/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/git/git.git"
	EGIT_BRANCH=maint
	inherit git-r3
else
	SRC_URI="https://mirrors.edge.kernel.org/pub/software/scm/git/${P}.tar.xz"
	KEYWORDS="amd64 arm64"
fi

LICENSE="GPL-2"
SLOT="0"

IUSE="static-libs perl gitweb"

DEPEND="
	sys-devel/gettext
	app-net/curl
	lib-core/libpcre2
	lib-core/expat
"

src_prepare() {
	if [[ ${PV} == *9999 ]] ; then
		eautoreconf
	fi

	default
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
}
