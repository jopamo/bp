# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="gcc implementation virtual."
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="gcc-lib nogcc"

RDEPEND="
	gcc-lib? (
		app-build/gcc-lib
		!app-build/gcc
	)
	!gcc-lib? (
		app-build/gcc
		!app-build/gcc-lib
	)
	nogcc? (
		!app-build/gcc-lib
		!app-build/gcc
	)
"
