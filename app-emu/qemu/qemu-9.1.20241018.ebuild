# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic xdg

DESCRIPTION="QEMU with enhanced support for multiple architectures and options"
HOMEPAGE="https://www.qemu.org/"

SNAPSHOT=0ff5ab6f57a2427a3e83969b2e7dd71e04caae39
SRC_URI="https://github.com/qemu/qemu/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/qemu-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="network-sandbox"

IUSE="alsa sdl vnc"

DEPEND="
	lib-dev/jemalloc
	lib-net/slirp
    app-core/attr
    lib-core/zlib
    lib-dev/libtasn1
    lib-net/libssh
    lib-util/glib
"

src_prepare() {
	filter-flags -Wl,-z,defs -flto*

	default
	mkdir -p build
}

src_configure() {
	cd build

	local myconf=(
		--prefix="${EPREFIX}"/usr
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/bin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--includedir="${EPREFIX}"/usr/include
		--datadir="${EPREFIX}"/usr/share
		--mandir="${EPREFIX}"/usr/share/man
		--infodir="${EPREFIX}"/usr/share/info
		--target-list=$(usex arm64 "aarch64-softmmu aarch64-linux-user" "x86_64-softmmu x86_64-linux-user")
		--enable-kvm
		--enable-qcow1
		--enable-virtfs
		--enable-vhost-crypto
		--enable-vhost-kernel
		--enable-vhost-net
		--enable-vhost-user
		#--enable-linux-io-uring
		--enable-malloc=jemalloc
        $(use_enable alsa)
        $(use_enable sdl)
        $(use_enable vnc)
	)
	../configure "${myconf[@]}"
}

src_compile() {
	cd build
	emake
}

src_install() {
	cd build
	emake DESTDIR="${ED}" install

	dostrip -x /usr/share/qemu
}
