# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Virtual for various service managers"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="runit"

RDEPEND="
	|| (
		!runit? ( app-core/systemd )
		runit? ( app-core/runit )
	)"
