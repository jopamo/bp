# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic python-single-r1

DESCRIPTION="A useful collection of mail servers, clients, and filters"
HOMEPAGE="https://www.gnu.org/software/mailutils/mailutils.html"
SRC_URI="mirror://gnu/mailutils/${P}.tar.xz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="frm sieve messages readmsg dotlock movemail mimeview mh gdbm ipv6
nls pam python servers ssl static-libs virtual-domains +sendmail +smtp
mailbox-imap mailbox-pop mailbox-mh +mailbox-maildir"

DEPEND="
	virtual/curses
	lib-core/readline
	gdbm? ( lib-core/gdbm )
	nls? ( app-build/gettext )
	pam? ( lib-core/pam )
	python? ( ${PYTHON_DEPS} )
	ssl? ( lib-net/gnutls )
"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

PATCHES=( "${FILESDIR}/${PN}-3.5-add-include.patch" )

filter-flags -Wl,-z,defs

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_configure() {
	append-flags -fno-strict-aliasing

	local myconf=(
		$(use_enable ipv6)
		$(use_with gdbm)
		$(use_enable nls)
		$(use_enable pam)
		$(use_enable smtp)
		$(use_enable sendmail)
		$(use_enable python)
		$(use_with ssl gnutls)
		$(use_enable static-libs static)
		$(use_enable servers build-servers)
		$(use_enable frm build-frm)
		--disable-build-mail
		$(use_enable sieve build-sieve)
		$(use_enable messages build-messages)
		$(use_enable readmsg build-readmsg)
		$(use_enable dotlock build-dotlock)
		$(use_enable movemail build-movemail)
		$(use_enable mimeview build-mimeview)
		$(use_enable mh build-mh)
		$(use_enable virtual-domains)
		$(use_enable mailbox-imap imap)
		$(use_enable mailbox-pop pop)
		$(use_enable mailbox-mh mh)
		$(use_enable mailbox-maildir maildir)
		--with-mail-spool=/var/spool/mail
		--with-readline
		--disable-debug
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	if use python; then
		python_optimize
		if use static-libs; then
			rm -r "${ED}"/$(python_get_sitedir)/mailutils/*.{a,la} || die
		fi
	fi

	rm "${ED}"/usr/share/man/man1/mail.1*
}
