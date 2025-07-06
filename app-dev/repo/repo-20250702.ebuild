# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit python-r1

DESCRIPTION="Google tool for managing git, particularly multiple repos"
HOMEPAGE="https://gerrit.googlesource.com/git-repo"
SNAPSHOT=5d95ba8d85e189c25195beae9431d5f6823e083a
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
