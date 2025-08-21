# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A library for reading and editing audio meta data"
HOMEPAGE="https://taglib.github.io/"
SNAPSHOT=fa96a6458e7ad577cc7bf9d4c6c518a433de0b59
SRC_URI="https://github.com/taglib/taglib/archive/${SNAPSHOT}.tar.gz -> taglib-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/taglib-${SNAPSHOT}"

LICENSE="LGPL-2.1 MPL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"
