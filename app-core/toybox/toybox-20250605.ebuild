# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="common Linux command line utilities together into a single BSD-licensed executable "
HOMEPAGE="http://landley.net/toybox/"

SNAPSHOT=957903785aff716990a61c16b6531334c7019e97
SRC_URI="https://github.com/landley/toybox/archive/${SNAPSHOT}.tar.gz -> toybox-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/toybox-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test strip"

BDEPEND="lib-core/musl"

create_toybox_symlinks() {
  TB_BIN="${EPREFIX}/usr/bin/toybox"

  if [ ! -x "$TB_BIN" ]; then
    echo "Error: $TB_BIN not found or not executable"
    return 1
  fi

  cd "${EPREFIX}/usr/bin" || return 1

  # Toybox lists commands when run with no arguments
  for cmd_name in $("$TB_BIN"); do
    [ "$cmd_name" = "toybox" ] && continue

    if [ ! -e "$cmd_name" ]; then
      echo "Creating symlink '${cmd_name}' -> 'toybox' in ${EPREFIX}/usr/bin/"
      ln -s "toybox" "$cmd_name"
    else
      echo "Skipping '${cmd_name}' - already exists in ${EPREFIX}/usr/bin/"
    fi
  done
}

src_configure() {
	make defconfig
}

src_compile() {
	filter-clang
	filter-flags -flto*
	append-ldflags -static
	append-ldflags -Wl,-z,noexecstack

	if command -v clang >/dev/null 2>&1; then
		echo "Detected clang"
		emake CC=musl-clang
	elif command -v gcc >/dev/null 2>&1; then
		echo "Detected gcc (no clang, fallback to gcc)"
		emake CC=musl-gcc
	else
		echo "No suitable compiler found" >&2
	fi
}

src_install() {
	dobin toybox
}

pkg_postinst() {
	create_toybox_symlinks
}
