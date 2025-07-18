# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Hardware RNG based on CPU timing jitter"
HOMEPAGE="https://github.com/smuellerDD/jitterentropy-library"
SNAPSHOT=b69901a4b445df31103c20d4be2f9314936d0eda
SRC_URI="https://github.com/smuellerDD/jitterentropy-library/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/jitterentropy-library-${SNAPSHOT}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	replace-flags -O2 -O0
	replace-flags -O3 -O0
	replace-flags -Os -O0
	replace-flags -Oz -O0

	default

	# Disable man page compression on install
	sed -e '/\tgzip.*man/ d' -i Makefile || die
	# Remove the default upstream optimization level
	sed -e '/^CFLAGS +=/ s|-O2||' -i Makefile || die
}

src_compile() {
	emake AR="$(tc-getAR)" CC="$(tc-getCC)"
}

src_install() {
	emake PREFIX="${EPREFIX}/usr" \
		  LIBDIR="lib" \
		  DESTDIR="${D}" \
		  INSTALL_STRIP="install" \
		  install $(usex static-libs install-static '')
}
