# Distributed under the terms of the GNU General Public License v2

EAPI=7

export CBUILD=${CBUILD:-${CHOST}}
export CTARGET=${CTARGET:-${CHOST}}

MY_PV=${PV/_/}

inherit toolchain-funcs

DESCRIPTION="GitHub CLI"
HOMEPAGE="https://github.com/cli/cli"

case ${PV}  in
*9999)
	EGIT_REPO_URI="https://github.com/golang/go.git"
	inherit git-r3
	;;
*)
	SRC_URI="https://storage.googleapis.com/golang/go${MY_PV}.src.tar.gz "
	S="${WORKDIR}"/go
esac

DESCRIPTION="A concurrent garbage collected and typesafe programming language"
HOMEPAGE="https://go.dev"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="!app-build/gcc[golang]"
BDEPEND="|| (
		app-lang/go
		app-lang/go-bootstrap )"

# the *.syso files have writable/executable stacks
QA_EXECSTACK='*.syso'

# Do not complain about CFLAGS, etc, since Go doesn't use them.
QA_FLAGS_IGNORED='.*'

QA_PREBUILT='.*'

# Do not strip this package. Stripping is unsupported upstream and may
# fail.
RESTRICT+=" strip"


go_arch() {
	# By chance most portage arch names match Go
	local tc_arch=$(tc-arch $@)
	case "${tc_arch}" in
		x64-*)	echo amd64;;
		*)		echo "${tc_arch}";;
	esac
}

go_os() {
	case "${1:-${CHOST}}" in
		*-linux*)	echo linux;;
		*)
			die "unknown GOOS for ${1:-${CHOST}}"
			;;
	esac
}

go_tuple() {
	echo "$(go_os $@)_$(go_arch $@)"
}

go_cross_compile() {
	[[ $(go_tuple ${CBUILD}) != $(go_tuple) ]]
}

src_compile() {
if has_version -b app-lang/go; then
		export GOROOT_BOOTSTRAP="${BROOT}/usr/lib/go"
	elif has_version -b app-lang/go-bootstrap; then
		export GOROOT_BOOTSTRAP="${BROOT}/usr/lib/go-bootstrap"
	else
		eerror "Go cannot be built without go or go-bootstrap installed"
		die "Should not be here, please report a bug"
	fi

	export GOROOT_FINAL="${EPREFIX}"/usr/lib/go
	export GOROOT="${PWD}"
	export GOBIN="${GOROOT}/bin"

	# Go's build script does not use BUILD/HOST/TARGET consistently. :(
	export GOHOSTARCH=$(go_arch ${CBUILD})
	export GOHOSTOS=$(go_os ${CBUILD})
	export CC=$(tc-getBUILD_CC)

	export GOARCH=$(go_arch)
	export GOOS=$(go_os)
	export CC_FOR_TARGET=$(tc-getCC)
	export CXX_FOR_TARGET=$(tc-getCXX)

	cd src
	bash -x ./make.bash || die "build failed"
}

src_test() {
	go_cross_compile && return 0

	cd src
	PATH="${GOBIN}:${PATH}" \
	./run.bash -no-rebuild || die "tests failed"
	cd ..
	rm -fr pkg/*_race || die
	rm -fr pkg/obj/go-build || die
}

src_install() {
	# There is a known issue which requires the source tree to be installed [1].
	# Once this is fixed, we can consider using the doc use flag to control
	# installing the doc and src directories.
	# The use of cp is deliberate in order to retain permissions
	# [1] https://golang.org/issue/2775
	dodir /usr/lib/go
	cp -R api bin doc lib pkg misc src test "${ED}"/usr/lib/go

	# testdata directories are not needed on the installed system
	rm -fr $(find "${ED}"/usr/lib/go -iname testdata -type d -print)

	local bin_path
	if go_cross_compile; then
		bin_path="bin/$(go_tuple)"
	else
		bin_path=bin
	fi
	local f x
	for x in ${bin_path}/*; do
		f=${x##*/}
		dosym ../lib/go/${bin_path}/${f} /usr/bin/${f}
	done

	# install the @golang-rebuild set for Portage
	insinto /usr/share/portage/config/sets
	newins "${FILESDIR}"/go-sets.conf go.conf

	cat > "${T}"/99${PN} <<- EOF || die
		GOPROXY=proxy.golang.org
	EOF
	doenvd "${T}"/99${PN}
}
