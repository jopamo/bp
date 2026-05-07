# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Virtual for the D-Bus message bus"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="X user-session"
REQUIRED_USE="X? ( user-session )"

RDEPEND="
	X? ( app-core/dbus-x11 )
	!X? (
		user-session? ( app-core/dbus[user-session] )
		!user-session? ( app-core/dbus[-user-session] )
	)
"
