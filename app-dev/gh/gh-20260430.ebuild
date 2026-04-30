# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=611b01f6c88c76671131ffe11cb9bec8502721b5
SHORT=${SNAPSHOT:0:9}

inherit flag-o-matic go-module

DESCRIPTION="GitHub CLI"
HOMEPAGE="https://github.com/cli/cli"
SRC_URI="https://github.com/cli/cli/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/cli-${SNAPSHOT}"

LICENSE="MIT Apache-2.0 BSD BSD-2 MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
BDEPEND+=" >=app-lang/go-1.26.20260305:="

RESTRICT="test"

src_compile() {
	export GH_VERSION="snapshot-${PV}-${SHORT}"

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
