# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="A library for reading and editing audio meta data"
HOMEPAGE="https://taglib.github.io/"
SNAPSHOT=78298769de7485850613b0589d70503b8a8fc81c
SRC_URI="https://github.com/taglib/taglib/archive/${SNAPSHOT}.tar.gz -> taglib-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/taglib-${SNAPSHOT}"

LICENSE="LGPL-2.1 MPL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"
