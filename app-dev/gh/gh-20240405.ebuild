# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic go-module

DESCRIPTION="GitHub CLI"
HOMEPAGE="https://github.com/cli/cli"

SNAPSHOT=3be7a02fec263e6feab954b1d996d159b82d6f93
SRC_URI="https://github.com/cli/cli/archive/${SNAPSHOT}.tar.gz -> cli-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/cli-${SNAPSHOT}"

LICENSE="MIT Apache-2.0 BSD BSD-2 MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	[[ ${PV} == *9999 ]] || export GH_VERSION="v${PV}"
	filter-flags "-flto*"
	filter-flags "-ggdb3"
	unset LDFLAGS

	emake

	einfo "Building man pages"
	emake manpages
}

src_install() {
	dobin bin/gh

	doman share/man/man?/gh*.?
}
