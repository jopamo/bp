# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Eselect module for management of multiple Python versions"
HOMEPAGE="https://www.gentoo.org/proj/en/Python/"
SRC_URI="https://dev.gentoo.org/~mgorny/dist/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND=">=app-admin/eselect-1.2.3
	>=dev-lang/python-exec-2.4.2"

pkg_postinst() {
	local py

	if has_version 'dev-lang/python'; then
		eselect python update --if-unset
	fi

	if has_version "=dev-lang/python-3*"; then
		eselect python update "--python3" --if-unset
	fi
}
