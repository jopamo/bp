# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs git-r3 autotools

DESCRIPTION="X.Org X11 library"

KEYWORDS="amd64 arm64"
IUSE="ipv6 test doc static-libs"
EGIT_REPO_URI="https://github.com/freedesktop/xorg-libX11.git"
SLOT=0

RDEPEND=">=x11-libs/libxcb-1.11.1
	x11-libs/xtrans
	x11/xorgproto"
DEPEND="${RDEPEND}
	test? ( dev-lang/perl )"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_with doc xmlto)
		$(use_enable doc specs)
		$(use_enable ipv6)
		--without-fop
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_compile() {
	if tc-is-cross-compiler; then
		# Make sure the build-time tool "makekeys" uses build settings.
		tc-export_build_env BUILD_CC
		emake -C src/util \
			CC="${BUILD_CC}" \
			CFLAGS="${BUILD_CFLAGS}" \
			LDFLAGS="${BUILD_LDFLAGS}" \
			clean all
	fi

	default
}
