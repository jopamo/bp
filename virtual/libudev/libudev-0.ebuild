# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Virtual for libudev providers"

SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs systemd"

RDEPEND="
	!systemd? ( || (
		sys-fs/eudev[static-libs(-)?]
	) )
	systemd? ( sys-app/systemd[static-libs(-)?] )
"
