# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Tool for running RAID systems - replacement for the raidtools"
HOMEPAGE="https://github.com/md-raid-utilities/mdadm"
SNAPSHOT=8f0c7692d48414ff7b3fe927ce75799c65ef24b1
SRC_URI="https://github.com/md-raid-utilities/mdadm/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/mdadm-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static systemd"

# prefer virtual/pkgconfig or dev-util/pkgconf in Gentoo
BDEPEND="virtual/pkgconfig"
DEPEND="
  app-compression/xz-utils
  app-core/util-linux
"

RESTRICT="test"

PATCHES=( "${FILESDIR}"/mdadm-portage.patch )

mdadm_emake() {
  emake \
    PKG_CONFIG="$(tc-getPKG_CONFIG)" \
    CC="$(tc-getCC)" \
    BINDIR="/usr/bin" \
    CWFLAGS="${MDADM_CWFLAGS} ${CPPFLAGS} ${CFLAGS}" \
    CXFLAGS="${CFLAGS}" \
    UDEVDIR="${EPREFIX}/usr/lib/udev" \
    SYSTEMD_DIR=$(usex systemd "${EPREFIX}/usr/lib/systemd/system" "false") \
    COROSYNC="-DNO_COROSYNC" \
    DLM="-DNO_DLM" \
    "$@"
}

src_compile() {
  # expose off64_t/lseek64 for untouched sources if needed
  append-cflags -D_LARGEFILE64_SOURCE

  # make warnings non-fatal and scrub any -Werror from user flags
  filter-flags -Werror -Werror=*
  append-cflags -Wno-error
  MDADM_CWFLAGS="-Wall -Wstrict-prototypes -Wextra -Wno-unused-parameter"

  use static && append-ldflags -static
  mdadm_emake all
}

src_test() {
  mdadm_emake test
  sh ./test || die
}

src_install() {
  mdadm_emake DESTDIR="${D}" install install-systemd
  insinto etc/mdadm
  doins "${FILESDIR}/mdadm.conf"
}
