# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Parse Options - Command line parser"
HOMEPAGE="http://rpm5.org/"
EGIT_REPO_URI="https://salsa.debian.org/debian/popt.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="nls static-libs"

RDEPEND="nls? ( >=sys-devel/gettext-0-r1 )"
DEPEND="nls? ( sys-devel/gettext )"

src_prepare() {
	sed -i -e 's:lt-test1:test1:' testit.sh || die
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		$(use_enable nls)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
