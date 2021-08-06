# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="fast compiler cache"
HOMEPAGE="https://ccache.samba.org/"
SRC_URI="https://github.com/ccache/ccache/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-compression/xz-utils
	lib-core/zlib"
RDEPEND="${DEPEND}
	dev-util/shadowman
	app-core/gentoo-functions"

src_prepare() {
	# make sure we always use system zlib
	rm -rf zlib || die
	eapply_user
	sed \
		-e "/^EPREFIX=/s:'':'${EPREFIX}':" \
		"${FILESDIR}"/ccache-config-3 > ccache-config || die
}

src_install() {
	default

	dobin ccache-config
	insinto /usr/share/shadowman/tools
	newins - ccache <<<'/usr/lib/ccache/bin'

	DOC_CONTENTS="
				To use ccache with **non-Portage** C compiling, add
				${EPREFIX}/usr/lib/ccache/bin to the beginning of your path, before ${EPREFIX}/usr/bin.
				Portage 2.0.46-r11+ will automatically take advantage of ccache with
				no additional steps.  If this is your first install of ccache, type
				something like this to set a maximum cache size of 2GB:\\n
				# ccache -M 2G\\n
				If you are upgrading from an older version than 3.x you should clear all of your caches like so:\\n
				# CCACHE_DIR='${CCACHE_DIR:-${PORTAGE_TMPDIR}/ccache}' ccache -C\\n
				ccache now supports sys-devel/clang and dev-lang/icc, too!"
}

pkg_prerm() {
	if [[ -z ${REPLACED_BY_VERSION} && ${ROOT} == / ]] ; then
		eselect compiler-shadow remove ccache
	fi
}

pkg_postinst() {
	if [[ ${ROOT} == / ]]; then
		eselect compiler-shadow update ccache
	fi

	# nuke broken symlinks from previous versions that shouldn't exist
	rm -rf "${EROOT}"/usr/lib/ccache.backup || die
}
