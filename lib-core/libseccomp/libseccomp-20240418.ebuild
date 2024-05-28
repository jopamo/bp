# Distributed under the terms of the GNU General Public License v2

EAPI=8

MAJOR_VERSION="2.5.5"

inherit autotools

DESCRIPTION="high level interface to Linux seccomp filter"
HOMEPAGE="https://github.com/seccomp/libseccomp"

SNAPSHOT=9da5d174e3ef219baab020a79c789f2075ace45c
SRC_URI="https://github.com/seccomp/libseccomp/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/libseccomp-${SNAPSHOT}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="app-kernel/linux-headers"
BDEPEND="app-dev/gperf"

src_prepare() {
	default
	eautoreconf
	sed -i -e "s/0.0.0/${MAJOR_VERSION}/g" "configure" || die
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		--disable-python
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
