# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Virtual for various service managers"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="openrc"

RDEPEND="
	|| (
		!openrc? ( app-core/systemd )
		openrc? ( app-core/openrc )
	)"
