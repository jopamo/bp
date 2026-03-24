# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qa-policy git-r3 meson

DESCRIPTION="a man replacement that utilizes gdbm instead of flat files"
HOMEPAGE="http://www.nongnu.org/man-db/"
EGIT_REPO_URI="https://gitlab.com/pjo/mandoc"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"
