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
	filter-clang
	filter-flags -flto*
	append-ldflags -static
	append-ldflags -Wl,-z,noexecstack

	if command -v musl-clang >/dev/null 2>&1; then
		echo "Detected musl-clang"
		emake CC=musl-clang
	elif command -v clang >/dev/null 2>&1; then
		echo "Detected clang (no musl-clang, fallback to clang)"
		emake CC="clang --target=$(uname -m)-linux-musl"
	elif command -v musl-gcc >/dev/null 2>&1; then
		echo "Detected musl-gcc"
		emake CC=musl-gcc
	elif command -v gcc >/dev/null 2>&1; then
		echo "Detected gcc (no musl, fallback to gcc)"
		emake CC=gcc
	else
		echo "No suitable compiler found" >&2
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
