# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs git-r3

DESCRIPTION="Hardware RNG based on CPU timing jitter"
HOMEPAGE="https://github.com/smuellerDD/jitterentropy-library"
EGIT_REPO_URI="https://github.com/smuellerDD/jitterentropy-rngd.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default

	# Disable man page compression on install
	sed -e '/\tgzip.*man/ d' -i Makefile || die
	# Let the package manager handle stripping
	sed -e '/\tinstall.*-s / s/-s //g' -i Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake PREFIX="${EPREFIX}/usr" \
		  LIBDIR="lib" \
		  DESTDIR="${D}" install

	doheader ${PN}.h ${PN}-base-user.h
}
