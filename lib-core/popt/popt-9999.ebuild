# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Parse Options - Command line parser"
HOMEPAGE="http://rpm5.org/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/rpm-software-management/popt.git"
	inherit git-r3
else
	SNAPSHOT=70011cc5763dca9a9b57e9539b465e00c9769996
	SRC_URI="https://github.com/rpm-software-management/popt/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/popt-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="MIT"
SLOT="0"

IUSE="static-libs"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-dependency-tracking
		$(use_enable static-libs static)
		--disable-nls
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
