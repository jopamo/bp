# Distributed under the terms of the GNU General Public License v2

EAPI=7


inherit distutils-r1 git-r3

DESCRIPTION="Check live packages for updates and emerge them as necessary"
HOMEPAGE="https://github.com/mgorny/smart-live-rebuild/"
EGIT_REPO_URI="https://github.com/mgorny/${PN}.git"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND=">=app-portage/gentoopm-0.2.1[${PYTHON_USEDEP}]"

python_test() {
	esetup.py test
}

python_install_all() {
	distutils-r1_python_install_all

	insinto /etc/portage
	newins smart-live-rebuild.conf{.example,}
	insinto /usr/share/portage/config/sets
	newins sets.conf.example smart-live-rebuild.conf
}
