# Distributed under the terms of the GNU General Public License v2

EAPI="5"

if [[ ${PV} == 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/gentoo/${PN}.git"
else
	SRC_URI="https://github.com/gentoo/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 arm64"
fi

inherit toolchain-funcs flag-o-matic

DESCRIPTION="base functions required by all Gentoo systems"
HOMEPAGE="https://www.gentoo.org"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

src_prepare() {
	tc-export CC
	append-lfs-flags
}

src_install() {
	emake install DESTDIR="${ED}"/usr
	rm -rf "${ED}"/usr/usr/
}
