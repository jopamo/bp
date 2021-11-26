# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION="a windowmanager for X that was based on the Blackbox"
HOMEPAGE="http://fluxbox.org/"
EGIT_REPO_URI="https://github.com/fluxbox/fluxbox"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-rpath
		--disable-slit
		--disable-fribidi
		--disable-imlib2
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	insinto /usr/share/fluxbox/
	for i in init menu apps ; do
			doins "${FILESDIR}/$i"
	done

	insinto /usr/share/fluxbox/styles/bora_black/
	newins "${FILESDIR}/bora_black_theme.cfg" theme.cfg
}
