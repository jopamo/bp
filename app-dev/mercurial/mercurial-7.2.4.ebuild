# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{13..14} )

inherit distutils-r1 doins

DESCRIPTION="Fast, scalable distributed source control management tool"
HOMEPAGE="https://www.mercurial-scm.org/"
SRC_URI="https://www.mercurial-scm.org/release/${P}.tar.gz"

LICENSE="GPL-2+ BSD MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	lib-net/ca-certificates
"
BDEPEND="
	app-build/gettext
	>=dev-pypi/setuptools-77[${PYTHON_USEDEP}]
	>=dev-pypi/setuptools-scm-8.1.0[${PYTHON_USEDEP}]
"

DISTUTILS_ARGS=( --no-rust )

export MERCURIAL_SETUP_FORCE_TRANSLATIONS=1
export SETUPTOOLS_SCM_PRETEND_VERSION_FOR_MERCURIAL="${PV}"

python_test() {
	local hg="${BUILD_DIR}/scripts/hg"
	local test_repo="${T}/mercurial-test-${EPYTHON}"
	local -x HGRCPATH=
	local -x LC_ALL=C

	[[ -x ${hg} ]] || die "built hg script not found"
	"${hg}" --config ui.username="bp test <root@localhost>" debuginstall \
		|| die "hg debuginstall failed"

	rm -rf "${test_repo}" || die
	"${hg}" init "${test_repo}" || die
	printf '%s\n' "packaged by bp" > "${test_repo}/tracked" || die
	"${hg}" --cwd "${test_repo}" add tracked || die
	"${hg}" --config ui.username="bp test <root@localhost>" \
		--cwd "${test_repo}" commit -m "package test" || die
	[[ $("${hg}" --cwd "${test_repo}" log -r . -T '{desc}') == "package test" ]] \
		|| die "committed revision was not readable"
}

python_install() {
	distutils-r1_python_install
	python_doscript contrib/hg-ssh
}

python_install_all() {
	distutils-r1_python_install_all

	dobin hgeditor
	newbashcomp contrib/bash_completion hg
	doman doc/*.?

	insinto /etc/mercurial/hgrc.d
	doins "${FILESDIR}/cacerts.rc"
}
