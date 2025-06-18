# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Utilities for rescue and embedded systems"
HOMEPAGE="https://www.busybox.net/"
SNAPSHOT=5f07327251c93184dfcfc8d978fc35705930ec53
SRC_URI="https://github.com/1g4-mirror/busybox/archive/${SNAPSHOT}.tar.gz -> hostap-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/busybox-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="minimal"

RESTRICT="test strip"

BDEPEND="lib-core/musl"

create_busybox_symlinks() {
  for path in $("${EROOT}/usr/bin/busybox" --list); do
    cmd_name=$(basename "$path")

    if [ ! -e "${EROOT}/usr/bin/${cmd_name}" ]; then
      echo "Creating symlink '${cmd_name}' in /usr/bin/"
      ln -s "${EROOT}/usr/bin/busybox" "${EROOT}/usr/bin/${cmd_name}"
    else
      echo "Skipping '${cmd_name}' - already exists in /usr/bin/"
    fi
  done
}

src_prepare() {
	filter-flags -fuse-ld=lld

	append-flags -ffat-lto-objects
	append-ldflags -static
	append-ldflags -Wl,-z,noexecstack

	default

	eapply "${FILESDIR}"/*.patch
	cp "${FILESDIR}"/busybox-config "${S}"/.config || die
	make silentoldconfig
}

src_compile() {
	CC=${CC:-gcc}

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
	create_busybox_symlinks
	dobin busybox
	doman docs/busybox.1
}
