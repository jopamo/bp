# Distributed under the terms of the GNU General Public License v2

inherit cmake xdg git-r3 flag-o-matic

DESCRIPTION="Qt helper library for single-instance applications"
HOMEPAGE="https://github.com/itay-grudev/SingleApplication"

EGIT_REPO_URI="https://github.com/itay-grudev/SingleApplication"

LICENSE="FreeArt GPL-3+ Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase"

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
