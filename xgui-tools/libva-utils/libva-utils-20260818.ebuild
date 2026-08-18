# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="VA-API utilities, including vainfo"
HOMEPAGE="https://github.com/intel/libva-utils"
SNAPSHOT=fb62481b3011bb6760cc3f247d45fb10cd61e452
SRC_URI="https://github.com/intel/libva-utils/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libva-utils-${SNAPSHOT}"

LICENSE="MIT BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="X wayland"

RDEPEND="
	xgui-lib/libva[drm,X?,wayland?]
"
DEPEND="${RDEPEND}"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	qa-policy-configure

	local myconf=(
		--enable-drm
		--disable-tests
		$(use_enable X x11)
		$(use_enable wayland)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_install() {
	default
	dobin "${FILESDIR}"/gpu-render-nodes
	qa-policy-install
}
