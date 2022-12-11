# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit python-single-r1 git-r3

DESCRIPTION="Synchronize files between a PC and an Android device using ADB"
HOMEPAGE="https://github.com/google/adb-sync"
EGIT_REPO_URI="${HOMEPAGE}.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="arm64 amd64"

RDEPEND="
	${PYTHON_DEPS}
	bin/platform-tools
"

src_install() {
	python_doscript adb-sync
}
