# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A library for reading and editing audio meta data"
HOMEPAGE="https://taglib.github.io/"

SNAPSHOT=e3de03501ff66221d1f1f971022b248d5b38ba06
SRC_URI="https://github.com/taglib/taglib/archive/${SNAPSHOT}.tar.gz -> taglib-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/taglib-${SNAPSHOT}"

LICENSE="LGPL-2.1 MPL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"
