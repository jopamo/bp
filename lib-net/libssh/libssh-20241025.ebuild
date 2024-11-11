# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Library implementing the SSH2 protocol"
HOMEPAGE="http://www.libssh.org/"

SNAPSHOT=861590192fed3627e80605be080f79aa2678a005
SRC_URI="https://git.libssh.org/projects/libssh.git/snapshot/libssh-${SNAPSHOT}.tar.xz"
S="${WORKDIR}/libssh-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
