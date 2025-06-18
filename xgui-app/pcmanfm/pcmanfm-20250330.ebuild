# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools xdg

DESCRIPTION="Extremely fast and lightweight file manager"
HOMEPAGE="https://github.com/lxde/pcmanfm"

SNAPSHOT=ce3d6cac1108ee3b136a0c67eb7dc2fb5babbf30
SRC_URI="https://github.com/lxde/pcmanfm/archive/${SNAPSHOT}.tar.gz -> pcmanfm-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/pcmanfm-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/libfm
	xgui-lib/gtk3
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--with-gtk=3
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	insopts -m 0755
	insinto etc/xdg/pcmanfm/default
	doins ${FILESDIR}/pcmanfm.conf
}
