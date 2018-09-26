# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils multilib-minimal

DESCRIPTION="high level interface to Linux seccomp filter"
HOMEPAGE="https://github.com/seccomp/libseccomp"
SRC_URI="https://github.com/seccomp/libseccomp/releases/download/v${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="static-libs"

DEPEND="sys-kernel/stable-sources"

src_prepare() {
	sed -i \
		-e '/_LDFLAGS/s:-static::' \
		tools/Makefile.in || die

	default
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable static-libs static)
		--disable-python
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
