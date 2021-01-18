# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="kernel headers implementation virtual."
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="musl"

RDEPEND="musl? ( sys-kernel/sabotage-headers[system-headers]
			!sys-kernel/linux-headers )
	!musl? ( sys-kernel/linux-headers
			!sys-kernel/sabotage-headers[system-headers] )"
