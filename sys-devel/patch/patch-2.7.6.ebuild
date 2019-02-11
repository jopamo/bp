# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit flag-o-matic eutils

DESCRIPTION="Utility to apply diffs to files"
HOMEPAGE="https://www.gnu.org/software/patch/patch.html"
SRC_URI="https://ftp.gnu.org/gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="static test xattr"

RDEPEND="xattr? ( sys-app/attr )"
DEPEND="${RDEPEND}
	test? ( sys-app/ed )"

src_configure() {
	use static && append-ldflags -static

	# Do not let $ED mess up the search for `ed` 470210.
	ac_cv_path_ED=$(type -P ed) \
	econf \
		$(use_enable xattr) \
		--program-prefix="$(use userland_BSD && echo g)"
}
