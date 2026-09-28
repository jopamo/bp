# Distributed under the terms of the GNU General Public License v2

inherit git-r3 meson qa-policy

DESCRIPTION="Native C HTML, DOM, and CSS libraries"
HOMEPAGE="https://gitlab.com/pjo/liblexa"
EGIT_REPO_URI="https://gitlab.com/pjo/liblexa"

LICENSE="MIT BSD-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"
BDEPEND="app-lang/python"

src_configure() {
	qa-policy-configure
	meson_src_configure
}

src_install() {
	meson_src_install

	if ! use static-libs; then
		rm "${ED}/usr/lib/liblexa.a" "${ED}/usr/lib/liblexa-html-candidate.a" || die
	fi

	qa-policy-install
}
