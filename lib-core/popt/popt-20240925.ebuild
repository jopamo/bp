# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Parse Options - Command line parser"
HOMEPAGE="http://rpm5.org/"

SNAPSHOT=63f096798125e96a0125faa477350f61901f3570
SRC_URI="https://github.com/rpm-software-management/popt/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/popt-${SNAPSHOT}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
