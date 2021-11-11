# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="libc implementation virtual."
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="musl"

RDEPEND="musl? (
			lib-core/musl[musl]
			!lib-core/glibc
)
		!musl? (
			lib-core/glibc
			lib-core/libxcrypt
			!lib-core/musl[musl]
)"
