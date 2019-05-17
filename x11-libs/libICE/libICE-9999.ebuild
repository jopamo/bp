# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="X.Org Inter-Client Exchange library"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/lib/${PN}.git"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="ipv6 doc static-libs"

RDEPEND="elibc_glibc? ( lib-dev/libbsd )
	x11-libs/xtrans
	x11-misc/xorgproto"
DEPEND="${RDEPEND}"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		$(use_enable ipv6)
		$(use_enable doc docs)
		$(use_enable doc specs)
		$(use_with doc xmlto)
		--without-fop
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
