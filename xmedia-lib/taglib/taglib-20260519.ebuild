# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="A library for reading and editing audio meta data"
HOMEPAGE="https://taglib.github.io/"
SNAPSHOT=a27dca557e85db1e23de33d2118cde87c8f32770
SRC_URI="https://github.com/taglib/taglib/archive/${SNAPSHOT}.tar.gz -> taglib-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/taglib-${SNAPSHOT}"

LICENSE="LGPL-2.1 MPL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"
