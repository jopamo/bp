# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Utility to optimize JPEG files"
HOMEPAGE="http://www.kokkonen.net/tjko/projects.html https://github.com/tjko/jpegoptim"
EGIT_REPO_URI="https://github.com/tjko/jpegoptim.git"

LICENSE="GPL-2+"
SLOT="0/1"
KEYWORDS="amd64 arm64"

DEPEND="lib-media/libjpeg-turbo"
