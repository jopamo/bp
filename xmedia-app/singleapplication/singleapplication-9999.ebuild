# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg git-r3 flag-o-matic

DESCRIPTION="Powerful yet simple to use screenshot software for GNU/Linux"
HOMEPAGE="https://github.com/itay-grudev/SingleApplication"

#SNAPSHOT=80001d5c1b2a4a5c1db8201d8c19f9f4d57c605a
#SRC_URI="https://github.com/flameshot-org/flameshot/archive/${SNAPSHOT}.tar.gz -> flameshot-${SNAPSHOT}.tar.gz"
#S="${WORKDIR}/flameshot-${SNAPSHOT}"

EGIT_REPO_URI="https://github.com/itay-grudev/SingleApplication"

LICENSE="FreeArt GPL-3+ Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase"

RESTRICT="network-sandbox"

src_configure() {
	append-flags -ffat-lto-objects

	local mycmakeargs=(
		-DQT_DEFAULT_MAJOR_VERSION=6
		-DQAPPLICATION_CLASS=FreeStandingSingleApplication
		-DSINGLEAPPLICATION_INSTALL=ON
		-DSINGLEAPPLICATION_DOCUMENTATION=OFF
	)
	cmake_src_configure
}
