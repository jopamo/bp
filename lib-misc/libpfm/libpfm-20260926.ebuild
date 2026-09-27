# Distributed under the terms of the GNU General Public License v2

inherit qa-policy toolchain-funcs

DESCRIPTION="Performance monitoring event library"
HOMEPAGE="https://github.com/wcohen/libpfm4"
SNAPSHOT=3d77461cb966259c51f3b3e322564187f4bef7fb
SRC_URI="https://github.com/wcohen/libpfm4/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libpfm4-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_compile() {
	emake -C lib PREFIX=/usr CC="$(tc-getCC)" AR="$(tc-getAR)" DBG= CONFIG_PFMLIB_DEBUG=n
}

src_install() {
	emake -C lib PREFIX=/usr DESTDIR="${D}" LDCONFIG=true install
	emake -C include PREFIX=/usr DESTDIR="${D}" install
	qa-policy-install
}
