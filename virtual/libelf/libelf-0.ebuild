# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="libelf implementation virtual"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="libelf"

RDEPEND="libelf? (
			lib-core/libelf
			!lib-core/elfutils
)
		!libelf? (
			lib-core/elfutils
			!lib-core/libelf
)"
