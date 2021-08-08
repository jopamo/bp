# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg-utils git-r3 meson

DESCRIPTION="The Shared MIME-info Database specification"
HOMEPAGE="https://freedesktop.org/wiki/Software/shared-mime-info"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xdg/shared-mime-info.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="lib-core/libxml2"
DEPEND="lib-live/glib
	dev-util/intltool
	sys-devel/gettext
	dev-util/pkgconf"
