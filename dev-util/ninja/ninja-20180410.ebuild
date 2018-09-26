# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit python-any-r1 toolchain-funcs

SNAPSHOT=ca041d88f4d610332aa48c801342edfafb622ccb

SRC_URI="https://github.com/ninja-build/ninja/archive/${SNAPSHOT}.zip -> ${P}.zip"
KEYWORDS="amd64 arm64 x86"
S=${WORKDIR}/${PN}-${SNAPSHOT}
DESCRIPTION="A small build system similar to make"
HOMEPAGE="https://ninja-build.org/"

LICENSE="Apache-2.0"
SLOT="0"

IUSE="test vim-syntax zsh-completion"

DEPEND="
	${PYTHON_DEPS}
	test? ( dev-cpp/gtest )
"
RDEPEND="
	vim-syntax? (
		|| (
			app-misc/vim
			app-misc/gvim
		)
	)
	zsh-completion? ( sys-app/zsh )
	!<app-misc/ninja-1.5.9_pre14-r1" #436804

run_for_build() {
	if tc-is-cross-compiler; then
		local -x AR=$(tc-getBUILD_AR)
		local -x CXX=$(tc-getBUILD_CXX)
		local -x CFLAGS=${BUILD_CXXFLAGS}
		local -x LDFLAGS=${BUILD_LDFLAGS}
	fi
	"$@"
}

src_compile() {
	tc-export AR CXX

	# configure.py uses CFLAGS instead of CXXFLAGS
	export CFLAGS=${CXXFLAGS}

	run_for_build "${PYTHON}" configure.py --bootstrap --verbose || die

	if tc-is-cross-compiler; then
		mv ninja ninja-build || die
		"${PYTHON}" configure.py || die
		./ninja-build -v ninja || die
	else
		ln ninja ninja-build || die
	fi
}

src_test() {
	if ! tc-is-cross-compiler; then
		# Bug 485772
		ulimit -n 2048
		./ninja-build -v ninja_test || die
		./ninja_test || die
	fi
}

src_install() {
	dobin ninja

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax/
		doins misc/"${PN}".vim

		echo 'au BufNewFile,BufRead *.ninja set ft=ninja' > "${T}/${PN}.vim"
		insinto /usr/share/vim/vimfiles/ftdetect
		doins "${T}/${PN}.vim"
	fi

	if use zsh-completion; then
		insinto /usr/share/zsh/site-functions
		newins misc/zsh-completion _ninja
	fi
}
