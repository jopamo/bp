# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Free implementation of Audio Processing Technology codec"
HOMEPAGE="https://github.com/iamthehorker/libfreeaptx"

SNAPSHOT=c176b7de9c2017d0fc1877659cea3bb6c330aafa
SRC_URI="https://github.com/iamthehorker/libfreeaptx/archive/${SNAPSHOT}.tar.gz -> libfreeaptx-${SNAPSHOT}.tar.gz"
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
