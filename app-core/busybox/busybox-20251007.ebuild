# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Utilities for rescue and embedded systems"
HOMEPAGE="https://www.busybox.net/"
SNAPSHOT=a0017a5b5038b3f803ece9140099410c8d4ed4b1
SRC_URI="https://github.com/1g4-mirror/busybox/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="minimal"

RESTRICT="test strip"

BDEPEND="lib-core/musl"

create_busybox_symlinks() {
  BB_BIN="${EPREFIX}/usr/bin/busybox"

  if [ ! -x "$BB_BIN" ]; then
    echo "Error: $BB_BIN not found or not executable"
    return 1
  fi

  for cmd_name in $("$BB_BIN" --list); do
    target="${EPREFIX}/usr/bin/${cmd_name}"
    if [ ! -e "$target" ]; then
      echo "Creating symlink '${cmd_name}' in ${EPREFIX}/usr/bin/"

      ln -s "busybox" "$target"
    else
      echo "Skipping '${cmd_name}' - already exists in ${EPREFIX}/usr/bin/"
    fi
  done
}

src_prepare() {
	default

	eapply "${FILESDIR}"/*.patch
	cp "${FILESDIR}"/busybox-config "${S}"/.config || die
	make silentoldconfig
}

src_compile() {
	filter-flags -flto*
	append-ldflags -static -no-pie -fno-PIE
	append-ldflags -Wl,-z,noexecstack
	emake CC=musl-gcc
}

src_install() {
	dobin busybox
	doman docs/busybox.1
}

pkg_postinst() {
	create_busybox_symlinks
}
