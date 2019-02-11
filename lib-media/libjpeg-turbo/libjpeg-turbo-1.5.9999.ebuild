# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal git-r3 autotools

DESCRIPTION="MMX, SSE, and SSE2 SIMD accelerated JPEG library"
HOMEPAGE="https://libjpeg-turbo.org/"
EGIT_REPO_URI="https://github.com/libjpeg-turbo/libjpeg-turbo.git"
EGIT_BRANCH="1.5.x"

LICENSE="BSD IJG"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="static-libs"

ASM_DEPEND="|| ( dev-lang/nasm dev-lang/yasm )"
COMMON_DEPEND="!lib-media/jpeg:0
	!lib-media/jpeg:62"
RDEPEND="${COMMON_DEPEND}"
DEPEND="${COMMON_DEPEND}
	amd64? ( ${ASM_DEPEND} )
	x86? ( ${ASM_DEPEND} )"

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
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
