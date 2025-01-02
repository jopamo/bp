# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="XCB utility functions for the X resource manager"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=a17de570ab18bfd8b7b9bf23af9e0bb2249d02c9
SRC_URI="https://github.com/Airblader/xcb-util-xrm/archive/${SNAPSHOT}.tar.gz -> xcb-util-xrm-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/xcb-util-xrm-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	./autogen.sh
}
