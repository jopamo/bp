# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Keyboard and console utilities"
HOMEPAGE="http://kbd-project.org/"

if [[ ${PV} == "9999" ]] ; then
	inherit autotools git-r3
	EGIT_REPO_URI="https://git.kernel.org/cgit/linux/kernel/git/legion/${PN}.git"
	EGIT_BRANCH="master"
else
	SRC_URI="https://www.kernel.org/pub/linux/utils/kbd/${P}.tar.xz"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="pam test"

RDEPEND="pam? ( lib-core/pam )
	app-compression/pigz"
DEPEND="${RDEPEND}
	app-dev/pkgconf
	test? ( lib-dev/check )"

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_enable pam vlock) \
		$(use_enable test tests)
}
