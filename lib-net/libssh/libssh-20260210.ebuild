# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Library implementing the SSH2 protocol"
HOMEPAGE="http://www.libssh.org/"
SNAPSHOT=f13a8d7ced240456d9002460bfc243c3097e77e5
SRC_URI="https://git.libssh.org/projects/libssh.git/snapshot/libssh-${SNAPSHOT}.tar.xz"
S="${WORKDIR}/libssh-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_configure() {
	local mycmakeargs=(
		-DWITH_STATIC_LIB=$(usex static-libs)
	)
	cmake_src_configure
}
