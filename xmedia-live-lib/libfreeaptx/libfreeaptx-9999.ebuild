# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Free implementation of Audio Processing Technology codec"
HOMEPAGE="https://github.com/iamthehorker/libfreeaptx"
EGIT_REPO_URI="https://github.com/iamthehorker/libfreeaptx.git"

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
