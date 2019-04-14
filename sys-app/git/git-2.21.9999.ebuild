# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="Git is a fast, scalable, distributed revision control system with a rich command set that provides high-level operations and full access to internals."
HOMEPAGE="http://www.git-scm.com/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/git/git.git"
	EGIT_BRANCH=maint
	inherit git-r3
	KEYWORDS="amd64 arm64"
else
	SNAPSHOT=aeb582a98374c094361cba1bd756dc6307432c42
	SRC_URI="https://github.com/git/git/archive/${SNAPSHOT}.zip -> ${P}.zip"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="~amd64 ~arm64"
fi

LICENSE="GPL-2"
SLOT="0"

DEPEND="sys-devel/gettext
		lib-dev/openssl
		app-net/curl
		lib-dev/libpcre2
		lib-dev/expat"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--with-libpcre2
		--with-curl
		--with-expat
		--with-openssl
		--without-tcltk
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
