# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Gentoo Repo Compatibility Package Lists"
HOMEPAGE="https://1g4.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="gui qt"

S=${WORKDIR}

src_prepare() {
	cp -rp "${FILESDIR}"/* "${S}"/
	default
}

src_compile() { :; }

src_test() { :; }

src_install() {
	insinto /etc/portage/profile/package.provided
	insopts -m0644

	doins 00-base

	for x in gui qt ; do
		use "${x}" && doins "00-${x}"
	done
}
