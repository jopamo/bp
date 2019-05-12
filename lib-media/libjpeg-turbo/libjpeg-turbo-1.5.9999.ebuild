# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="MMX, SSE, and SSE2 SIMD accelerated JPEG library"
HOMEPAGE="https://libjpeg-turbo.org/"
EGIT_REPO_URI="https://github.com/libjpeg-turbo/libjpeg-turbo.git"
EGIT_BRANCH="$(ver_cut 1).$(ver_cut 2).x"

LICENSE="BSD IJG"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="static-libs"

DEPEND="|| ( dev-lang/nasm dev-lang/yasm )"

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
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
