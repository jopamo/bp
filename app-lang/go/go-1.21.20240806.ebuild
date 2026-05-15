# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="release-branch.go$(ver_cut 1-2)"

export CBUILD=${CBUILD:-${CHOST}}
export CTARGET=${CTARGET:-${CHOST}}

inherit toolchain-funcs

DESCRIPTION="A concurrent garbage collected and typesafe programming language"
HOMEPAGE="https://go.dev"

SNAPSHOT=8bba868de983dd7bf55fcd121495ba8d6e2734e7
SRC_URI="https://github.com/golang/go/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/go-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="app-build/gcc[go-bootstrap]"

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
	case "$(go_arch)" in
		amd64)
			export GOARCH="amd64"
			export GOAMD64="v1"
			;;
		arm64)
			export GOARCH="arm64"
			unset GOAMD64
			;;
	esac
}

src_prepare() {
	default
	export GOROOT_FINAL="/usr/lib/go"
}

setup_gccgo_bootstrap() {
	local host_root="${BROOT%/}"
	local host_usr="${host_root}/usr"
	local bootstrap_go="${host_usr}/lib/gccgo/bin/go"
	local bootstrap_root="${T}/gccgo-bootstrap"
	local entry

	[[ -x ${bootstrap_go} ]] || die "missing gccgo bootstrap go tool: ${bootstrap_go}"

	# Upstream expects gccgo bootstrap as GOROOT_BOOTSTRAP=/usr with bin/go
	# provided by gccgo. We keep the gccgo go binary out of /usr/bin to avoid
	# file collisions with app-lang/go, so build a temporary GOROOT-shaped tree.
	rm -rf "${bootstrap_root}" || die
	mkdir -p "${bootstrap_root}/bin" || die
	ln -s "${bootstrap_go}" "${bootstrap_root}/bin/go" || die

	if [[ -x ${host_usr}/lib/gccgo/bin/gofmt ]]; then
		ln -s "${host_usr}/lib/gccgo/bin/gofmt" "${bootstrap_root}/bin/gofmt" || die
	fi

	if [[ -e ${host_usr}/pkg ]]; then
		ln -s "${host_usr}/pkg" "${bootstrap_root}/pkg" || die
	else
		mkdir -p "${bootstrap_root}/pkg" || die
		if [[ -d ${host_usr}/include ]]; then
			ln -s "${host_usr}/include" "${bootstrap_root}/pkg/include" || die
		fi
	fi

	for entry in include lib libexec share src; do
		[[ -e ${host_usr}/${entry} ]] || continue
		ln -s "${host_usr}/${entry}" "${bootstrap_root}/${entry}" || die
	done

	export GOROOT_BOOTSTRAP="${bootstrap_root}"
}

src_compile() {
	setup_gccgo_bootstrap

	export GOROOT_FINAL="${EPREFIX}/usr/lib/go"
	export GOROOT="${PWD}"
	export GOBIN="${GOROOT}/bin"
	export GOHOSTARCH="$(go_arch)"
	export GOHOSTOS=linux
	export CC="$(tc-getBUILD_CC)"
	export GOARCH="$(go_arch)"
	export GOOS=linux
	export CC_FOR_TARGET="$(tc-getCC)"
	export CXX_FOR_TARGET="$(tc-getCXX)"
	export GOCACHE="${T}/go-build"
	export GOMODCACHE="${WORKDIR}/go-mod"

	cd src || die "Failed to change directory to src"
	./make.bash || die "Build failed"
}

src_test() {
	cd src
	export GOROOT="${S}"
	export GOBIN="${GOROOT}/bin"
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
