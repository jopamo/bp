# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="An easy-to-use hash implementation for C programmers"
HOMEPAGE="https://troydhanson.github.io/uthash/index.html"
EGIT_REPO_URI="https://github.com/troydhanson/uthash.git"

LICENSE="BSD-1"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	doheader src/*.h
}
