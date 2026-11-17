# Distributed under the terms of the GNU General Public License v2

inherit qa-policy

DESCRIPTION="Create, inspect and extract ISO 9660 filesystem images"
HOMEPAGE="https://www.gnu.org/software/xorriso/"
SRC_URI="https://www.gnu.org/software/xorriso/xorriso-1.5.6.pl02.tar.gz"
S="${WORKDIR}/xorriso-1.5.6"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl bzip2 readline xattr zlib"
REQUIRED_USE="bzip2? ( zlib )"

RDEPEND="
	acl? ( app-core/acl )
	bzip2? ( app-compression/bzip2 )
	readline? ( lib-core/readline virtual/curses )
	zlib? ( lib-core/zlib )
"
DEPEND="${RDEPEND}"

src_configure() {
	qa-policy-configure
	econf \
		--disable-libcdio \
		--disable-libedit \
		$(use_enable acl libacl) \
		$(use_enable bzip2 libbz2) \
		$(use_enable readline libreadline) \
		$(use_enable xattr) \
		$(use_enable zlib)
}

src_test() {
	default
	mkdir "${T}/iso-input" || die
	printf '1g4 ISO round trip\n' > "${T}/iso-input/payload" || die
	xorriso/xorriso -no_rc -as mkisofs \
		-o "${T}/test.iso" "${T}/iso-input" || die
	xorriso/xorriso -no_rc -osirrox on -indev "${T}/test.iso" \
		-extract /payload "${T}/payload" || die
	cmp "${T}/iso-input/payload" "${T}/payload" || die
}

src_install() {
	# Install the CLI and aliases, without the Tcl/Tk and USB-writing scripts.
	emake DESTDIR="${D}" bin_SCRIPTS= \
		man_MANS="xorriso/xorriso.1 xorriso/xorrisofs.1 xorriso/xorrecord.1" \
		INFO_DEPS="xorriso/xorriso.info xorriso/xorrisofs.info xorriso/xorrecord.info" \
		install
	qa-policy-install
}
