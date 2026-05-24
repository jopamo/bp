# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs

DESCRIPTION="Implementation of the meson build system in C99"
HOMEPAGE="https://muon.build https://github.com/muon-build/muon"
SNAPSHOT=e4887e72628c0b28cb0808fc6c2cdcfd269b2fb9
SRC_URI="https://github.com/muon-build/muon/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-compression/libarchive
	app-net/curl
"
RDEPEND="
	${DEPEND}
	app-dev/pkgconf
"
BDEPEND="app-dev/pkgconf"

src_compile() {
	CC="$(tc-getCC)" ./bootstrap.sh bootstrap-build || die

	./bootstrap-build/muon-bootstrap setup \
		-Dbuildtype=release \
		-Dprefix=/usr \
		-Dlibarchive=enabled \
		-Dlibcurl=enabled \
		-Dlibpkgconf=disabled \
		-Dtracy=disabled \
		-Dman-pages=disabled \
		-Dmeson-docs=disabled \
		-Dmeson-tests=disabled \
		-Dwebsite=disabled \
		build || die

	./bootstrap-build/muon-bootstrap -C build samu || die
}

src_install() {
	dobin build/muon
}
