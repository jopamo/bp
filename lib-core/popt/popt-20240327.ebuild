# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Parse Options - Command line parser"
HOMEPAGE="http://rpm5.org/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/rpm-software-management/popt.git"
	inherit git-r3
else
	SNAPSHOT=1e7bc3883afe26c60c511bd4caf2f3c37803c06f
	SRC_URI="https://github.com/rpm-software-management/popt/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/popt-${SNAPSHOT}
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
