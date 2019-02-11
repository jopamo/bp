# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3 multilib-minimal

DESCRIPTION="POSIX 1003.1e capabilities"
HOMEPAGE="https://people.redhat.com/sgrubb/libcap-ng/"
EGIT_REPO_URI="https://github.com/stevegrubb/libcap-ng.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test"

src_prepare() {
	sed -i -e 's:AM_CONFIG_HEADER:AC_CONFIG_HEADERS:' configure.ac || die
	${S}/autogen.sh
	eautoreconf
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
		--without-python
		--without-python3
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
