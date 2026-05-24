# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=6a4418c36d6bad69a599044b3cf49dcbd049cb45

inherit autotools qa-policy

DESCRIPTION="Git is a fast, scalable, distributed revision control system"
HOMEPAGE="http://www.git-scm.com/"

SRC_URI="https://github.com/git/git/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/git-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="curl static-libs +perl gitweb"
REQUIRED_USE="
	gitweb? ( perl )
"

RDEPEND="
	curl? ( app-net/curl )
	lib-core/libpcre2
	lib-core/expat
	perl? ( app-lang/perl )
"
DEPEND="
	${RDEPEND}
	app-build/gettext
	app-lang/python
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	qa-policy-configure
	local myconf=(
		--with-libpcre2
		$(use_with curl)
		--with-expat
		--with-python=/usr/bin/python3
		--without-openssl
		--without-tcltk
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_compile() {
	local emakeargs=(
		NO_RUST=YesPlease
	)

	use perl || emakeargs+=( NO_PERL=YesPlease )
	use gitweb || emakeargs+=( NO_GITWEB=YesPlease )

	emake "${emakeargs[@]}" all
}

src_install() {
	local emakeargs=(
		NO_RUST=YesPlease
	)

	use perl || emakeargs+=( NO_PERL=YesPlease )
	use gitweb || emakeargs+=( NO_GITWEB=YesPlease )

	emake "${emakeargs[@]}" DESTDIR="${D}" install
	use static-libs || find "${ED}" -name "*.a" -delete || die

	insopts -m 0644
	insinto /etc
	doins "${FILESDIR}"/gitconfig

	qa-policy-install
}
