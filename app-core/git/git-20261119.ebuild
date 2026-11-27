# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=f7de81456940dd6f3274e461149bba12965de609

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
	perl? (
		app-lang/perl
		core-perl/Authen-SASL
		core-perl/IO-Socket-SSL
		core-perl/MailTools
	)
"
DEPEND="
	${RDEPEND}
	app-build/gettext
	app-lang/python
"

PATCHES=(
	"${FILESDIR}/git-reftable-test-tag.patch"
	"${FILESDIR}/git-blame-test-expr.patch"
	"${FILESDIR}/git-format-patch-signature.patch"
)

src_prepare() {
	default
	local version
	version=$(GIT_VERSION= sh ./GIT-VERSION-GEN "${S}" \
		'--format=@GIT_MAJOR_VERSION@.@GIT_MINOR_VERSION@.@GIT_MICRO_VERSION@') || die
	[[ ${version} =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || die "Unexpected Git version: ${version}"
	printf '#define BP_FORMAT_PATCH_SIGNATURE "%s.lol.g%s"\n' \
		"${version}" "${SNAPSHOT:0:12}" > builtin/bp-format-patch-signature.h || die
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
