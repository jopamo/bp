# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="high level interface to Linux seccomp filter"
HOMEPAGE="https://github.com/seccomp/libseccomp"
SRC_URI="https://github.com/seccomp/libseccomp/releases/download/v${PV}/${P}.tar.gz"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/seccomp/libseccomp.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=1e64feb5f1a9ea02687228e3073e8b784a04ce46
	SRC_URI="https://github.com/seccomp/libseccomp/archive/${SNAPSHOT}.zip -> ${P}.zip"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="static-libs"

DEPEND="sys-kernel/stable-sources"

src_prepare() {
	default
	eautoreconf
	sed -i.bak -e "s/0.0.0/2.3.9999/g" "configure"
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable static-libs static)
		--disable-python
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	chrpath -d "${ED}"/usr/bin/scmp_sys_resolver

}
