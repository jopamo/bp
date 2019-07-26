# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="A JSON implementation in C"
HOMEPAGE="https://github.com/json-c/json-c/wiki"

if [[ ${PV} == *9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/json-c/json-c.git"
	EGIT_BRANCH=json-c-0.13
else
	SNAPSHOT=
	SRC_URI="https://github.com/json-c/json-c/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="MIT"
SLOT="0/3"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default
	sed -i -e "s:-Werror::" configure.ac || die
	eautoreconf
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_test() {
	export USE_VALGRIND=0 VERBOSE=1
	default
}

src_install() {
	default
	dosym ../json-c /usr/include/json-c/json
}
