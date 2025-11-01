# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="v$(ver_cut 1).x"

inherit flag-o-matic python-any-r1 toolchain-funcs xdg

DESCRIPTION="A JavaScript runtime built on Chrome's V8 JavaScript engine"
HOMEPAGE="https://nodejs.org/"
SNAPSHOT=c611ea6fc979a597220fb4d458d340d0a74e0ab1
SRC_URI="https://github.com/nodejs/node/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/node-${SNAPSHOT}

LICENSE="Apache-1.1 Apache-2.0 BSD BSD-2 MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug icu inspector lto node-snapshot npm ssl test"

REQUIRED_USE="
	inspector? ( icu ssl )
	npm? ( ssl )
"

RESTRICT="!test? ( test )"

DEPEND="${RDEPEND}"
RDEPEND="
	app-compression/brotli
	lib-dev/libuv
	lib-net/c-ares
	lib-dev/nghttp2
	lib-core/zlib
	icu? ( lib-dev/icu )
	ssl? ( virtual/ssl )
"
BDEPEND="
	${PYTHON_DEPS}
	app-core/coreutils
	app-dev/pkgconf
	test? ( app-net/curl )
"

src_prepare() {
	sed -i -e "s/NODE_VERSION_IS_RELEASE\ 0/NODE_VERSION_IS_RELEASE\ 1/g" "src/node_version.h" || die

	use lto || filter-flags -flto\*

	tc-export AR CC CXX PKG_CONFIG
	export V=1
	export BUILDTYPE=Release

	# less verbose install output (stating the same as portage, basically)
	#sed -i -e "/print/d" tools/install.py || die

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
		$(use_with inspector)
		$(usex debug --debug '')
		$(usex icu '--with-intl=system-icu' '--with-intl=none')
		$(usex lto --enable-lto '')
		$(usex node-snapshot '' --without-node-snapshot)
		$(usex npm '' --without-npm)
		$(usex ssl '--shared-openssl --openssl-use-def-ca-store' '--without-ssl')
	)

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
		"${myconf[@]}" || die
}
