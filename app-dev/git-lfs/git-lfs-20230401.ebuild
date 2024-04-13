# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Command line extension and specification for managing large files with git"
HOMEPAGE="https://git-lfs.com/"

SNAPSHOT=bea0287cdd3acbc0aa9cdf67ae09b6843d3ffcf0
SRC_URI="https://github.com/git-lfs/git-lfs/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="Apache-2.0 BSD BSD-2 BSD-4 ISC MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

RESTRICT+=" !test? ( test )"

src_compile() {
	go get -u
	go mod vendor
	go mod tidy

	# Flags -w, -s: Omit debugging information to reduce binary size,
	# see https://golang.org/cmd/link/.
	local mygobuildargs=(
		-ldflags="-X ${EGO_PN}/config.GitCommit=${GIT_COMMIT} -s -w"
		-mod vendor -v -work -x
	)
	go build "${mygobuildargs[@]}" -o git-lfs git-lfs.go || die
}

src_install() {
	dobin git-lfs
}

src_test() {
	local mygotestargs=(
		-ldflags="-X ${EGO_PN}/config.GitCommit=${GIT_COMMIT}"
		-mod vendor
	)
	go test "${mygotestargs[@]}" ./... || die
}

pkg_postinst () {
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		elog ""
		elog "Run 'git lfs install' once for each user account manually."
		elog "For more details see https://bugs.gentoo.org/show_bug.cgi?id=733372."
	fi
}
