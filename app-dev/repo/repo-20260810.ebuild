# Distributed under the terms of the GNU General Public License v2

inherit python-r1

DESCRIPTION="Google tool for managing git, particularly multiple repos"
HOMEPAGE="https://gerrit.googlesource.com/git-repo"
SNAPSHOT=b85886fa9f5b4e2189cc5b2f40bd0a80459d4c77
SRC_URI="https://github.com/GerritCodeReview/git-repo/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/git-repo-${SNAPSHOT}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}"

src_install() {
	python_foreach_impl python_doscript repo
	doman man/*.[0-9]
}
