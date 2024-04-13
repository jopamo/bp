# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="high level interface to Linux seccomp filter"
HOMEPAGE="https://github.com/seccomp/libseccomp"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="${HOMEPAGE}.git"
	inherit git-r3
else
	SNAPSHOT=f1c3196d9b95de22dde8f23c5befcbeabef5711c
	SRC_URI="${HOMEPAGE}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/libseccomp-${SNAPSHOT}
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="app-kernel/linux-headers"
BDEPEND="app-dev/gperf"

src_prepare() {
	default
	eautoreconf
	sed -i -e "s/0.0.0/$(ver_cut 1-3)/g" "configure" || die
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		--disable-python
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
