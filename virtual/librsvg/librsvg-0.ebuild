# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="librsvg implementation virtual"

SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="librsvg-og"

RDEPEND="librsvg-og? (
			xgui-live-lib/librsvg-og
			!xgui-live-lib/librsvg
)
		!librsvg-og? (
			xgui-live-lib/librsvg
			!xgui-live-lib/librsvg-og
)"
