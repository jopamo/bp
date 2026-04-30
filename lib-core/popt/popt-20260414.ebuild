# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="Parse Options - Command line parser"
HOMEPAGE="http://rpm5.org/"

SNAPSHOT=8631d608e507385da472b4119e980982ce281af0
SRC_URI="https://github.com/rpm-software-management/popt/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/popt-${SNAPSHOT}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
