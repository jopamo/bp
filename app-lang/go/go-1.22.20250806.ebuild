# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="release-branch.go$(ver_cut 1-2)"

export CBUILD=${CBUILD:-${CHOST}}
export CTARGET=${CTARGET:-${CHOST}}

inherit toolchain-funcs

DESCRIPTION="A concurrent garbage collected and typesafe programming language"
HOMEPAGE="https://go.dev"
SNAPSHOT=5817e650946aaa0ac28956de96b3f9aa1de4b299
SRC_URI="https://github.com/golang/go/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/go-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

QA_EXECSTACK='*.syso'
QA_PREBUILT='.*'
QA_FLAGS_IGNORED='.*'
RESTRICT="strip"

go_arch() {
	local triple="${1:-${CHOST}}"

	case "${triple}" in
		*amd64*) echo amd64;;
		*x86_64*) echo amd64;;
		*arm64*) echo arm64;;
		*aarch64*) echo arm64;;
		*) die "Unsupported architecture";;
	esac
}

src_prepare() {
	default
}

src_compile() {
	export GOROOT_BOOTSTRAP="${BROOT%/}/usr/lib/go"
	export GOHOSTARCH="$(go_arch "${CBUILD}")"
	export GOHOSTOS=linux
	export CC="$(tc-getBUILD_CC)"
	export GOARCH="$(go_arch)"
	export GOOS=linux
	export CC_FOR_TARGET="$(tc-getCC)"
	export CXX_FOR_TARGET="$(tc-getCXX)"
	export GOCACHE="${T}/go-build"
	export GOMODCACHE="${WORKDIR}/go-mod"

	cd src || die "Failed to change directory to src"
	bash ./make.bash || die "Build failed"
}

src_test() {
	cd src
	export GO_TEST_TIMEOUT_SCALE=3
	PATH="${S}/bin:${PATH}" \
	./run.bash --no-rebuild -v -v -v -k || die "tests failed"
	cd ..
	rm -fr pkg/*_race || die
	rm -fr pkg/obj/go-build || die
}

src_install() {
	dodir /usr/lib/go
	cp -a . "${ED}"/usr/lib/go || die "Failed to copy Go files"

	find "${ED}"/usr/lib/go -iname testdata -type d -exec rm -rf {} +

	local go_bin

	for go_bin in go gofmt; do
		dosym -r "/usr/lib/go/bin/${go_bin}" "/usr/bin/${go_bin}"
	done

	cat > "${T}"/99go <<- EOF || die
		GOPROXY=proxy.golang.org
		GOROOT=${EPREFIX}/usr/lib/go
		GOPATH=${EPREFIX}/usr/share/go
	EOF
	doenvd "${T}"/99go
}
