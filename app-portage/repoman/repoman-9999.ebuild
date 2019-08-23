# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1 git-r3

DESCRIPTION="Repoman is a Quality Assurance tool for Gentoo ebuilds"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Portage"
EGIT_REPO_URI="https://github.com/gentoo/portage.git"
S="${WORKDIR}/${P}/repoman"

LICENSE="GPL-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

DEPEND="
	sys-app/portage[${PYTHON_USEDEP}]
	>=dev-python/lxml-3.6.0[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
"

python_prepare_all() {
	distutils-r1_python_prepare_all

	find ${S} -type f -print0 | xargs -0 sed -i 's/\/var\/db\/repos\/gentoo/\/var\/db\/repos\/bp/g'
}

python_test() {
	esetup.py test
}

python_install() {
	# Install sbin scripts to bindir for python-exec linking
	# they will be relocated in pkg_preinst()
	distutils-r1_python_install \
		--system-prefix="${EPREFIX}/usr" \
		--bindir="$(python_get_scriptdir)" \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		--htmldir="${EPREFIX}/usr/share/doc/${PF}/html" \
		--sbindir="$(python_get_scriptdir)" \
		--sysconfdir="${EPREFIX}/etc" \
		"${@}"
}
