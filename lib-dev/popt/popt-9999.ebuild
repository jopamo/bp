# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils multilib-minimal autotools git-r3

DESCRIPTION="Parse Options - Command line parser"
HOMEPAGE="http://rpm5.org/"
EGIT_REPO_URI="https://github.com/devzero2000/POPT.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="nls static-libs"

RDEPEND="nls? ( >=sys-devel/gettext-0-r1[${MULTILIB_USEDEP}] )"
DEPEND="nls? ( sys-devel/gettext )"

src_prepare() {
	sed -i -e 's:lt-test1:test1:' testit.sh || die
	eautoreconf
	default
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		$(use_enable nls)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
