# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1 git-r3

DISTUTILS_USE_PEP517=setuptools

DESCRIPTION="Synchronize files between a PC and an Android device using ADB"
HOMEPAGE="https://github.com/jb2170/better-adb-sync"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="arm64 amd64"
