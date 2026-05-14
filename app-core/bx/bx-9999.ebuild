# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson qa-policy

DESCRIPTION="multi-tool"
HOMEPAGE="https://gitlab.com/pjo/bx"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://gitlab.com/pjo/bx"
	inherit git-r3
else
	SNAPSHOT=8046be5c26d9c24c9cee044c10bc4a84c61d3f8f
	SRC_URI="https://gitlab.com/pjo/bx/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+static test"

RDEPEND="
	static? ( app-net/mira[static(+)] )
	!static? ( app-net/mira[-static] )
"
DEPEND="${RDEPEND}"

src_configure() {
	qa-policy-configure

	local emesonargs=(
		$(meson_use test tests)
		-Dmira_embed=enabled
		-Dstatic_binary=$(usex static enabled disabled)
	)

	meson_src_configure
}

src_install() {
	meson_src_install
	qa-policy-install
}
