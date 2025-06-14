# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Free implementation of Audio Processing Technology codec"
HOMEPAGE="https://github.com/regularhunter/libfreeaptx"
SNAPSHOT=6dee419f934ec781e531f885f7e8e740752e67d1
SRC_URI="https://github.com/regularhunter/libfreeaptx/archive/${SNAPSHOT}.tar.gz -> libfreeaptx-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libfreeaptx-${SNAPSHOT}"

LICENSE="Apache-2"
SLOT="0"
KEYWORDS="arm64 amd64"

src_compile() {
	emake \
		PREFIX="${EPREFIX}"/usr \
		LIBDIR="lib" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		ARFLAGS="${ARFLAGS} -rcs" \
		all
}

src_install() {
	emake \
		PREFIX="${EPREFIX}"/usr \
		DESTDIR="${D}" \
		LIBDIR="lib" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		ARFLAGS="${ARFLAGS} -rcs" \
		install
}
