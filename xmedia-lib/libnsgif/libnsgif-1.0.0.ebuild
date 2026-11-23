# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs qa-policy

DESCRIPTION="GIF decoding library from the NetSurf project"
HOMEPAGE="https://www.netsurf-browser.org/projects/libnsgif/"
BS_SNAPSHOT=b38fe7146aa3af08881ba9d6817f19ee7abe4a86
SRC_URI="
	https://download.netsurf-browser.org/libs/releases/${P}-src.tar.gz
	https://github.com/netsurf-browser/buildsystem/archive/${BS_SNAPSHOT}.tar.gz -> netsurf-buildsystem-${BS_SNAPSHOT}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

nsgif_make() {
	emake PREFIX="${EPREFIX}/usr" LIBDIR=lib \
		NSSHARED="${WORKDIR}/buildsystem-${BS_SNAPSHOT}" \
		COMPONENT_TYPE=lib-shared "$@"
}

src_compile() {
	qa-policy-configure
	tc-export AR CC
	nsgif_make all
}

src_test() {
	nsgif_make test
}

src_install() {
	nsgif_make DESTDIR="${D}" install
	qa-policy-install
}
