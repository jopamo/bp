# Distributed under the terms of the GNU General Public License v2

inherit flag-o-matic toolchain-funcs xdg

DESCRIPTION="Linux Studio Plugins"
HOMEPAGE="https://lsp-plug.in"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lsp-plugins/lsp-plugins"
	EGIT_BRANCH="devel"
else
	SRC_URI="https://github.com/lsp-plugins/${PN}/releases/download/${PV}/${PN}-src-${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 arm64"
	S="${WORKDIR}/${PN}"
fi

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="jack +ladspa +lv2 test +vst X"


REQUIRED_USE="
	test? ( jack )
	|| ( ladspa lv2 vst )
"

RESTRICT="!test? ( test )"

DEPEND="
	xmedia-lib/libglvnd
	xgui-lib/libsndfile
	ladspa? ( xmedia-lib/ladspa-sdk )
"
RDEPEND="${DEPEND}"

_lsp_plugins_set_makeargs() {
	local features=()

	use jack && features+=( jack )
	use ladspa && features+=( ladspa )
	use lv2 && features+=( lv2 )
	use vst && features+=( vst2 )
	use X && features+=( xdg )

	LSP_PLUGINS_MAKEARGS=(
		FEATURES="${features[*]}"
		PREFIX="/usr"
		LIBDIR="/usr/lib"
		CC="$(tc-getCC)"
		CXX="$(tc-getCXX)"
		LD="$(tc-getLD)"
		CFLAGS_EXT="${CFLAGS}"
		CXXFLAGS_EXT="${CXXFLAGS}"
		LDFLAGS_EXT="$(raw-ldflags)"
		VERBOSE=1
	)
}

src_configure() {
	# -Werror=odr
	# https://bugs.gentoo.org/875833
	#
	# Actually the whole thing is kind of a waste of time. It looks like
	# programs use LDFLAGS, but libraries do not! So some things don't
	# build with LTO, while other things don't build when LTO is enabled.
	# Attempting to build with LTO is just a waste of time and cycles.
	#
	# This was reported upstream but the ticket closed. Abandon hope.
	filter-lto

	_lsp_plugins_set_makeargs
	emake "${LSP_PLUGINS_MAKEARGS[@]}" config
}

src_compile() {
	_lsp_plugins_set_makeargs
	emake "${LSP_PLUGINS_MAKEARGS[@]}"
}

src_install() {
	_lsp_plugins_set_makeargs
	emake "${LSP_PLUGINS_MAKEARGS[@]}" DESTDIR="${ED}" install
}
