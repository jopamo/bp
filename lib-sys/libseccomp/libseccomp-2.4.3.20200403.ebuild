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
	SNAPSHOT=c561096f6d8ec584ec3ff4aa7caded19842d8b28
	SRC_URI="https://github.com/seccomp/libseccomp/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="sys-kernel/linux-headers"

src_prepare() {
	default
	eautoreconf
	sed -i.bak -e "s/0.0.0/$(ver_cut 1).$(ver_cut 2).$(ver_cut 3)/g" "configure"
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		--disable-python
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	chrpath -d "${ED}"/usr/bin/scmp_sys_resolver
	use static-libs || find "${ED}" -name '*.la' -delete

}
