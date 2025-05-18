# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Modern audio compression for the internet"
HOMEPAGE="https://opus-codec.org/"

SNAPSHOT=08bcc6e46227fca01aa3de3f3512f8b692d8d36b
SRC_URI="https://github.com/xiph/opus/archive/${SNAPSHOT}.tar.gz -> opus-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/opus-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
