# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Parse Options - Command line parser"
HOMEPAGE="http://rpm5.org/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/rpm-software-management/popt.git"
	inherit git-r3
else
	SNAPSHOT=819145732782b21cdd24fb8d1c1cd3e09dbf3ace
	SRC_URI="https://github.com/rpm-software-management/popt/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/popt-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="MIT"
SLOT="0"
