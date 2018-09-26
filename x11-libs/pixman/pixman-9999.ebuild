# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal git-r3 autotools

DESCRIPTION="Low-level pixel manipulation routines"
EGIT_REPO_URI="https://anongit.freedesktop.org/git/pixman.git"
SLOT=0

KEYWORDS="amd64 arm64 x86"

IUSE="altivec iwmmxt loongson2f cpu_flags_x86_mmxext neon cpu_flags_x86_sse2 cpu_flags_x86_ssse3"

src_prepare() {
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
		$(use_enable cpu_flags_x86_mmxext mmx)
		$(use_enable cpu_flags_x86_sse2 sse2)
		$(use_enable cpu_flags_x86_ssse3 ssse3)
		$(use_enable altivec vmx)
		$(use_enable neon arm-neon)
		$(use_enable iwmmxt arm-iwmmxt)
		$(use_enable loongson2f loongson-mmi)
		--disable-gtk
		--disable-libpng
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
