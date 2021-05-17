# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 systemd flag-o-matic

DESCRIPTION="Hardware RNG based on CPU timing jitter"
HOMEPAGE="https://github.com/smuellerDD/jitterentropy-library"
EGIT_REPO_URI="https://github.com/smuellerDD/jitterentropy-rngd.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="systemd"

PATCHES=( "${FILESDIR}"/${PN}-do-not-strip-and-compress.patch )

replace-flags -O2 -O0
replace-flags -O3 -O0
replace-flags -Os -O0

src_install() {
	emake PREFIX="${EPREFIX}/usr" \
		  LIBDIR="lib" \
		  DESTDIR="${D}" install

	use systemd && systemd_dounit "${FILESDIR}"/${PN}.service

}
