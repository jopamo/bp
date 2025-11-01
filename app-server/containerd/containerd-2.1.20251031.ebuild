# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="release/$(ver_cut 1-2)"

inherit go-module

DESCRIPTION="A daemon to control runC"
HOMEPAGE="https://containerd.io/"
SNAPSHOT=0e9625edbb641c4abda673c3551ea055e9a9a2d4
SRC_URI="https://github.com/containerd/containerd/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/containerd-${SNAPSHOT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="apparmor btrfs device-mapper cri hardened seccomp selinux systemd test"

BDEPEND="app-tex/go-md2man"

RESTRICT+="test"

src_prepare() {
	default
	sed -i \
		-e "s/-s -w//" \
		-e "s/-mod=readonly//" \
		Makefile || die
	sed -i \
		-e "s:/usr/local:/usr:" \
		containerd.service || die
}

src_compile() {
	local options=(
		$(usev apparmor)
		$(usex btrfs "" "no_btrfs")
		$(usex cri "" "no_cri")
		$(usex device-mapper "" "no_devmapper")
		$(usev seccomp)
		$(usev selinux)
	)

	myemakeargs=(
		BUILDTAGS="${options[*]}"
		LDFLAGS="$(usex hardened '-extldflags -fno-PIC' '')"
		REVISION="${GIT_REVISION}"
		VERSION=v${PV}
	)

	# race condition in man target https://bugs.gentoo.org/765100
	# we need to explicitly specify GOFLAGS for "go run" to use vendor source
	emake "${myemakeargs[@]}" man -j1 #nowarn
	emake "${myemakeargs[@]}" all

}

src_install() {
	dobin bin/*
	doman man/*

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins containerd.service
	fi

	rm -r docs/man || die
}
