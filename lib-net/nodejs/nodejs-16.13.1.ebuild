# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic python-any-r1 toolchain-funcs xdg-utils

DESCRIPTION="A JavaScript runtime built on Chrome's V8 JavaScript engine"
HOMEPAGE="https://nodejs.org/"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nodejs/node"
else
	SRC_URI="https://nodejs.org/dist/v${PV}/node-v${PV}.tar.xz"
	S="${WORKDIR}/node-v${PV}"
fi

LICENSE="Apache-1.1 Apache-2.0 BSD BSD-2 MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug +icu inspector lto +npm +snapshot +ssl +system-icu +system-ssl systemtap test"

REQUIRED_USE="
	inspector? ( icu ssl )
	npm? ( ssl )
	system-icu? ( icu )
	system-ssl? ( ssl )
"

RESTRICT="!test? ( test )"

DEPEND="${RDEPEND}"
RDEPEND="
	app-compression/brotli
	lib-dev/libuv
	lib-net/c-ares
	lib-live/nghttp2
	lib-core/zlib
	system-icu? ( lib-dev/icu )
	system-ssl? ( virtual/ssl )
"
BDEPEND="
	${PYTHON_DEPS}
	app-core/coreutils
	app-dev/pkgconf
	systemtap? ( app-dev/systemtap )
	test? ( app-net/curl )
"

PATCHES=(
	"${FILESDIR}"/${PN}-12.22.5-shared_c-ares_nameser_h.patch
	"${FILESDIR}"/${PN}-15.2.0-global-npm-config.patch
)

src_prepare() {
	use lto || filter-flags -flto\*

	tc-export AR CC CXX PKG_CONFIG
	export V=1
	export BUILDTYPE=Release

	# less verbose install output (stating the same as portage, basically)
	sed -i -e "/print/d" tools/install.py || die

	# Avoid writing a depfile, not useful
	sed -i -e "/DEPFLAGS =/d" tools/gyp/pylib/gyp/generator/make.py || die

	sed -i -e "/'-O3'/d" common.gypi node.gypi || die

	# debug builds. change install path, remove optimisations and override buildtype
	if use debug; then
		sed -i -e "s|out/Release/|out/Debug/|g" tools/install.py || die
		BUILDTYPE=Debug
	fi

	# All this test does is check if the npm CLI produces warnings of any sort,
	# failing if it does. Overkill, much? Especially given one possible warning
	# is that there is a newer version of npm available upstream (yes, it does
	# use the network if available), thus making it a real possibility for this
	# test to begin failing one day even though it was fine before.
	rm -f test/parallel/test-release-npm.js

	default
}

src_configure() {
	xdg_environment_reset

	local myconf=(
		--shared-brotli
		--shared-cares
		--shared-libuv
		--shared-nghttp2
		--shared-zlib
	)
	use debug && myconf+=( --debug )
	use lto && myconf+=( --enable-lto )
	if use system-icu; then
		myconf+=( --with-intl=system-icu )
	elif use icu; then
		myconf+=( --with-intl=full-icu )
	else
		myconf+=( --with-intl=none )
	fi
	use inspector || myconf+=( --without-inspector )
	use npm || myconf+=( --without-npm )
	use snapshot || myconf+=( --without-node-snapshot )
	if use ssl; then
		use system-ssl && myconf+=( --shared-openssl --openssl-use-def-ca-store )
	else
		myconf+=( --without-ssl )
	fi

	local myarch=""
	case ${ABI} in
		amd64) myarch="x64";;
		arm64) myarch="arm64";;
		*) myarch="${ABI}";;
	esac

	GYP_DEFINES="linux_use_gold_flags=0
		linux_use_bundled_binutils=0
		linux_use_bundled_gold=0" \
	"${EPYTHON}" configure.py \
		--prefix="${EPREFIX}"/usr \
		--dest-cpu=${myarch} \
		$(use_with systemtap dtrace) \
		"${myconf[@]}" || die
}
