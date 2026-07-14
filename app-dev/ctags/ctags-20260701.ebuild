# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="A maintained ctags implementation"
HOMEPAGE="https://ctags.io/"
SNAPSHOT=5437fa6249e95ec55a5f4944dac28f4f6e46c195
SRC_URI="https://github.com/universal-ctags/ctags/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT CC-BY-3.0"
SLOT="0"
KEYWORDS="amd64 arm64"

QA_CONFIG_IMPL_DECL_SKIP=(
	libiconv_open
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local econfargs=(
		--disable-etags
		--enable-tmpdir=/tmp
	)
	econf "${econfargs[@]}"
}
