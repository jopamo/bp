# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="Linux tools for UDF filesystems and DVD/CD-R(W) drives"
HOMEPAGE="https://github.com/pali/udftools/ https://sourceforge.net/projects/linux-udf/"
EGIT_REPO_URI="https://github.com/pali/udftools.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-core/readline:0="

src_prepare() {
	default
	eautoreconf
}
