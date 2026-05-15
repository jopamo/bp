# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="release-branch.go$(ver_cut 1-2)"

export CBUILD=${CBUILD:-${CHOST}}
export CTARGET=${CTARGET:-${CHOST}}

inherit toolchain-funcs

DESCRIPTION="A concurrent garbage collected and typesafe programming language"
HOMEPAGE="https://go.dev"
SNAPSHOT=edc1e4a5f2af48b648502d987b8d4eebf43c884b
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

go_prune_live_root() {
	local live_root="${EROOT%/}/usr/lib/go"
	local image_root="${ED%/}/usr/lib/go"
	local rel

	[[ -d ${live_root} && -d ${image_root} ]] || return 0

	while IFS= read -r -d '' rel; do
		rel=${rel#./}
		[[ -e ${image_root}/${rel} || -L ${image_root}/${rel} ]] && continue
		rm -rf "${live_root}/${rel}" || die "failed pruning stale Go path: ${live_root}/${rel}"
	done < <(cd "${live_root}" && find . -mindepth 1 -depth -print0)
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

pkg_preinst() {
	go_prune_live_root
}
