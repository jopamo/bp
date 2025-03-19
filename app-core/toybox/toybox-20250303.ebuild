# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="common Linux command line utilities together into a single BSD-licensed executable "
HOMEPAGE="http://landley.net/toybox/"

SNAPSHOT=12bbc85e8a4cc190a818e8f3126e73433448c9a6
SRC_URI="https://github.com/landley/toybox/archive/${SNAPSHOT}.tar.gz -> toybox-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test strip"

BDEPEND="lib-core/musl"

create_toybox_symlinks() {
  for path in $("${ED}"/usr/bin/toybox --long); do
    cmd_name=$(basename "$path")

    if [ ! -e "${EROOT}/usr/bin/${cmd_name}" ]; then
      echo "Creating symlink '${cmd_name}' in ${ED}/usr/bin/"
      dosym -r /usr/bin/toybox "/usr/bin/${cmd_name}"
    else
      echo "Skipping '${cmd_name}' - already exists in /usr/bin/"
    fi
  done
}

src_configure() {
	make defconfig
}

src_compile() {
	append-ldflags -static
	export OPTIMIZE="${CFLAGS}"

	default
}

src_install() {
	dobin toybox
	create_toybox_symlinks
}
