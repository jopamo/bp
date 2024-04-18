# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit python-r1

DESCRIPTION="Google tool for managing git, particularly multiple repos"
HOMEPAGE="https://gerrit.googlesource.com/git-repo"

SNAPSHOT=9d865454aaf0ea41927332768e55b5b2f56e2533
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
