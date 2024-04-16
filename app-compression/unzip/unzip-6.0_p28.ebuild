# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic

MY_PV="${PV//.}"
MY_PV="${MY_PV%_p*}"
MY_P="${PN}${MY_PV}"

DESCRIPTION="unzipper for pkzip-compressed files"
HOMEPAGE="http://www.info-zip.org/"
SRC_URI="mirror://sourceforge/infozip/${MY_P}.tar.gz
	mirror://debian/pool/main/u/${PN}/${PN}_${PV/_p/-}.debian.tar.xz"

S="${WORKDIR}/unzip60"

LICENSE="Info-ZIP"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bzip2 unicode"

DEPEND="bzip2? ( app-compression/bzip2 )"

src_prepare() {
	local deb="${WORKDIR}"/debian/patches
	#rm "${deb}"/{02*,11*,22*,23*,24*,25*,26*,28*}.patch || die
	eapply "${deb}"/*.patch

	eapply "${FILESDIR}"/${PN}-6.0-no-exec-stack.patch
	eapply "${FILESDIR}"/${PN}-6.0-format-security.patch

	sed -i -r \
		-e '/^CFLAGS/d' \
		-e '/CFLAGS/s:-O[0-9]?:$(CFLAGS) $(CPPFLAGS):' \
		-e '/^STRIP/s:=.*:=true:' \
		-e "s:\<CC *= *\"?g?cc2?\"?\>:CC=\"$(tc-getCC)\":" \
		-e "s:\<LD *= *\"?(g?cc2?|ld)\"?\>:LD=\"$(tc-getCC)\":" \
		-e "s:\<AS *= *\"?(g?cc2?|as)\"?\>:AS=\"$(tc-getCC)\":" \
		-e 's:LF2 = -s:LF2 = :' \
		-e 's:LF = :LF = $(LDFLAGS) :' \
		-e 's:SL = :SL = $(LDFLAGS) :' \
		-e 's:FL = :FL = $(LDFLAGS) :' \
		-e "/^#L_BZ2/s:^$(use bzip2 && echo .)::" \
		-e 's:$(AS) :$(AS) $(ASFLAGS) :g' \
		unix/Makefile \
		|| die "sed unix/Makefile failed"

	# Delete bundled code to make sure we don't use it.
	rm -r bzip2 || die

	eapply_user
}

src_configure() {
	append-cppflags -DNO_LCHMOD
	use bzip2 && append-cppflags -DUSE_BZIP2
	use unicode && append-cppflags -DUNICODE_SUPPORT -DUNICODE_WCHAR -DUTF8_MAYBE_NATIVE -DUSE_ICONV_MAPPING
	append-cppflags -DLARGE_FILE_SUPPORT #281473
}

src_compile() {
	ASFLAGS="${ASFLAGS} ${CFLAGS}" \
		emake -f unix/Makefile unzips
}

src_install() {
	dobin unzip funzip unzipsfx unix/zipgrep
	dosym unzip /usr/bin/zipinfo
	doman man/*.1
}
