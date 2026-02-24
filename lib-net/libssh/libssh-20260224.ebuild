# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake dot-a

DESCRIPTION="Library implementing the SSH2 protocol"
HOMEPAGE="http://www.libssh.org/"
SNAPSHOT=90b07e2c18ba3a36ce842c4828407f72fb390c55
SRC_URI="https://git.libssh.org/projects/libssh.git/snapshot/libssh-${SNAPSHOT}.tar.xz"
S="${WORKDIR}/libssh-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_configure() {
	use static-libs && lto-guarantee-fat

	local mycmakeargs=(
		-DWITH_STATIC_LIB=$(usex static-libs)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	use static-libs && strip-lto-bytecode
}
