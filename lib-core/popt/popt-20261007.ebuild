# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="Parse Options - Command line parser"
HOMEPAGE="http://rpm5.org/"

SNAPSHOT=af6f19e5968d48608a062d6d92d28b7fd248f8ea
SRC_URI="https://github.com/rpm-software-management/popt/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/popt-${SNAPSHOT}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
