# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="release-branch.go$(ver_cut 1-2)"

export CBUILD=${CBUILD:-${CHOST}}
export CTARGET=${CTARGET:-${CHOST}}

inherit toolchain-funcs

DESCRIPTION="A concurrent garbage collected and typesafe programming language"
HOMEPAGE="https://go.dev"
SNAPSHOT=562709bcf5b8f480d722d2f369d7757cb135e9ab
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
	case "${CHOST}" in
		*amd64*) echo amd64;;
		*x86_64*) echo amd64;;
		*arm64*) echo arm64;;
		*aarch64*) echo arm64;;
		*) die "Unsupported architecture";;
	esac
}

pkg_setup() {
	export GOARCH="amd64"
	export GOAMD64="v1"
}

src_prepare() {
	default
	export GOROOT_FINAL="/usr/lib/go"
	export GOROOT_BOOTSTRAP="/usr/lib/go"
}

src_compile() {
	export GOROOT_FINAL="${EPREFIX}/usr/lib/go"
	export GOROOT="${PWD}"
	export GOBIN="${GOROOT}/bin"
	export GOHOSTARCH=$(go_arch ${CHOST})
	export GOHOSTOS=linux
	export CC=$(tc-getBUILD_CC)
	export GOARCH=$(go_arch)
	export GOOS=linux
	export CC_FOR_TARGET=$(tc-getCC)
	export CXX_FOR_TARGET=$(tc-getCXX)
	export GOCACHE="${T}/go-build"
	export GOMODCACHE="${WORKDIR}/go-mod"

	cd src || die "Failed to change directory to src"
	./make.bash || die "Build failed"
}

src_test() {
	cd src
	export GO_TEST_TIMEOUT_SCALE=3
	PATH="${GOBIN}:${PATH}" \
	./run.bash --no-rebuild -v -v -v -k || die "tests failed"
	cd ..
	rm -fr pkg/*_race || die
	rm -fr pkg/obj/go-build || die
}

src_install() {
	dodir /usr/lib/go
	cp -a api bin lib pkg misc src test "${ED}"/usr/lib/go || die "Failed to copy Go files"

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
