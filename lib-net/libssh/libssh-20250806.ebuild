# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Library implementing the SSH2 protocol"
HOMEPAGE="http://www.libssh.org/"
SNAPSHOT=ef50a3c0f0686d708f08ee4754e80d68569831b7
SRC_URI="https://git.libssh.org/projects/libssh.git/snapshot/libssh-${SNAPSHOT}.tar.xz"
S="${WORKDIR}/libssh-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
