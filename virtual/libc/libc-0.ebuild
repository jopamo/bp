# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="libc implementation virtual."
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="musl"

RDEPEND="musl? ( lib-sys/musl[systemwide]
			!lib-sys/glibc )
	!musl? ( lib-sys/glibc
			!lib-sys/musl[systemwide] )"
