# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="libc implementation virtual"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="elibc_musl? (
			lib-core/musl[elibc_musl]
			!lib-core/glibc
)
		!elibc_musl? (
			lib-core/glibc
			lib-core/libxcrypt
			!lib-core/musl[elibc_musl]
)"
