# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Utilities for rescue and embedded systems"
HOMEPAGE="https://www.busybox.net/"

SNAPSHOT=411543949605fd7e9c996a0a2aadf8b344a4ced0
SRC_URI="https://git.busybox.net/busybox/snapshot/busybox-${SNAPSHOT}.tar.bz2 -> ${P}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="minimal"

RESTRICT="test strip"

BDEPEND="lib-core/musl"

create_busybox_symlinks() {
  for path in $(/usr/bin/busybox --list); do
    cmd_name=$(basename "$path")

    if [ ! -e "${EROOT}/usr/bin/${cmd_name}" ]; then
      echo "Creating symlink '${cmd_name}' in /usr/bin/"
      ln -s /usr/bin/busybox "/usr/bin/${cmd_name}"
    else
      echo "Skipping '${cmd_name}' - already exists in /usr/bin/"
    fi
  done
}

src_prepare() {
	append-flags -ffat-lto-objects
	append-ldflags -static

	default

	eapply "${FILESDIR}"/*.patch
	cp "${FILESDIR}"/busybox-config "${S}"/.config || die
	make silentoldconfig
}

src_compile() {
	if ${CC} --version | grep -q 'clang'; then
		echo "Detected Clang"
		emake CC=musl-clang
	elif ${CC} --version | grep -q 'gcc'; then
		echo "Detected GCC"
		emake CC=musl-gcc
	else
		echo "Unknown compiler"
		exit 1
	fi
}

src_install() {
	dobin busybox
	doman docs/busybox.1
}

pkg_postinst() {
	create_busybox_symlinks
}
