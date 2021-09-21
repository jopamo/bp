# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Eselect module for management of multiple Python versions"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Python"
SRC_URI="https://dev.gentoo.org/~chutzpah/dist/misc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	app-misc/eselect
	dev-lang/python-exec
"

pkg_postinst() {
	local py

	if has_version 'dev-lang/python'; then
		eselect python update --if-unset
	fi

	if has_version "=dev-lang/python-3*"; then
		eselect python update "--python3" --if-unset
	fi
}
