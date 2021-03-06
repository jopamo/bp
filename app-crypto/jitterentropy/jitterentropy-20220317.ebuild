# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Hardware RNG based on CPU timing jitter"
HOMEPAGE="https://github.com/smuellerDD/jitterentropy-library"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="${HOMEPAGE}.git"
	inherit git-r3
else
	SNAPSHOT=2e5019cfe63038faaa405ce53715effe4ea580e4
	SRC_URI="${HOMEPAGE}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-library-${SNAPSHOT}
fi

LICENSE="BSD"
SLOT="0"
#KEYWORDS="amd64 arm64"

IUSE="static-libs"

replace-flags -O2 -O0
replace-flags -O3 -O0
replace-flags -Os -O0
replace-flags -Oz -O0

src_prepare() {
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
