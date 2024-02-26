# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit python-r1

DESCRIPTION="Google tool for managing git, particularly multiple repos"
HOMEPAGE="https://gerrit.googlesource.com/git-repo"
SRC_URI="https://github.com/GerritCodeReview/git-repo/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

SNAPSHOT=4217a82bec7b95c1a0bc7b081a1764a6a6d6c59b
SRC_URI="https://github.com/GerritCodeReview/git-repo/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/git-repo-${SNAPSHOT}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}"

src_install() {
	python_foreach_impl python_doscript ${PN}
	doman man/*.[0-9]
}
