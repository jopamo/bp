# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools multilib-minimal

DESCRIPTION="A JSON implementation in C"
HOMEPAGE="https://github.com/json-c/json-c/wiki"
SRC_URI="https://github.com/json-c/json-c/archive/json-c-0.13.1-20180305.tar.gz"
S=${WORKDIR}/${PN}-${P}-20180305
LICENSE="MIT"
SLOT="0/3"
KEYWORDS="amd64 arm64 x86"
IUSE="static-libs"

src_prepare() {
	default
	sed -i -e "s:-Werror::" configure.ac || die
	eautoreconf

	# tests break otherwise
	multilib_copy_sources
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

multilib_src_test() {
	export USE_VALGRIND=0 VERBOSE=1
	default
}

multilib_src_install_all() {
	dosym ../json-c /usr/include/json-c/json
	find "${ED}" -name "*.la" -delete || die
}
