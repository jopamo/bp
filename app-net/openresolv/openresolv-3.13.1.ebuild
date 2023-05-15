# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A framework for managing DNS information"
HOMEPAGE="https://roy.marples.name/projects/openresolv"
SRC_URI="https://github.com/NetworkConfiguration/openresolv/releases/download/v${PV}/${P}.tar.xz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	local myconf=(
		--prefix="${EPREFIX}"
		--rundir="${EPREFIX}"/run
		--libexecdir="${EPREFIX}"/usr/lib/resolvconf
	)
	econf "${myconf[@]}"
}

pkg_config() {
	if [[ ${ROOT} != / ]]; then
		eerror "We cannot configure unless \$ROOT=/"
		return 1
	fi

	if [[ -n "$(resolvconf -l)" ]]; then
		einfo "${PN} already has DNS information"
	else
		ebegin "Copying /etc/resolv.conf to resolvconf -a dummy"
		resolvconf -a dummy </etc/resolv.conf
		eend $? || return $?
		einfo "The dummy interface will disappear when you next reboot"
	fi
}
