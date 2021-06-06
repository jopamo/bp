# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

DESCRIPTION="Repoman is a Quality Assurance tool for Gentoo ebuilds"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Portage"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/gentoo/portage.git"
	inherit git-r3
	S="${WORKDIR}/${P}/repoman"
else
	SNAPSHOT=b18d15009ba91ce2603f298290fccbe94d519ced
	SRC_URI="https://github.com/gentoo/portage/archive/${SNAPSHOT}.tar.gz -> portage-${PV}.tar.gz"
	S=${WORKDIR}/portage-${SNAPSHOT}/repoman
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	~sys-app/portage-${PV}[${PYTHON_USEDEP}]
	>=dev-python/lxml-3.6.0[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
"

python_prepare_all() {
	distutils-r1_python_prepare_all

	find "${S}" -type f -print0 | xargs -0 sed -i 's/\/var\/db\/repos\/gentoo/\/var\/db\/repos\/bp/g'
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
		--sbindir="$(python_get_scriptdir)" \
		--sysconfdir="${EPREFIX}/etc" \
		"${@}"
}
