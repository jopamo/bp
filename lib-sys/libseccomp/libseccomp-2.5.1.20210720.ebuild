# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="high level interface to Linux seccomp filter"
HOMEPAGE="https://github.com/seccomp/libseccomp"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/seccomp/libseccomp.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=01e5750e7c84bb14e5a5410c924bed519209db06
	SRC_URI="https://github.com/seccomp/libseccomp/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="sys-kernel/linux-headers"
BDEPEND="dev-util/gperf"

src_prepare() {
	default
	eautoreconf
	sed -i -e "s/0.0.0/$(ver_cut 1).$(ver_cut 2).$(ver_cut 3)/g" "configure" || die
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		--disable-python
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
