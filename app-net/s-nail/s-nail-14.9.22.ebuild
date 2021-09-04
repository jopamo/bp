# Distributed under the terms of the GNU General Public License v2

EAPI=8

HOMEPAGE="https://www.sdaoden.eu/code.html"
DESCRIPTION="Enhanced mailx-compatible mail client based on Heirloom mailx (nail)"
SRC_URI="https://ftp.sdaoden.eu/${P}.tar.xz"

LICENSE="BSD BSD-4 ISC RSA"
SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	local confopts=(
		strip="${EROOT}"/usr/bin/true
		OPT_AUTOCC=no
		VAL_PREFIX="${EPREFIX}"/usr
		VAL_SYSCONFDIR="${EPREFIX}"/etc
		VAL_MTA="${EPREFIX}/usr/sbin/sendmail"
		VAL_MAIL='/var/spool/mail'
		VAL_PAGER=less
		VERBOSE=1
	)

	emake "${confopts[@]}" config
}

src_compile() {
	emake build
}

src_install() {
	# Use /usr/sbin/sendmail by default and provide an example
	cat <<- EOSMTP >> nail.rc

		# Use the local sendmail (/usr/sbin/sendmail) binary by default.
		# (Uncomment the following line to use a SMTP server)
		#set smtp=localhost

		# Ask for CC: list too.
		set askcc
	EOSMTP

	emake DESTDIR="${D}" install

	dosym s-nail /usr/bin/mailx
	dosym mailx /usr/bin/mail
	dosym mailx /usr/bin/Mail

	dosym s-nail.1 /usr/share/man/man1/mailx.1
	dosym mailx.1 /usr/share/man/man1/mail.1
	dosym mailx.1 /usr/share/man/man1/Mail.1
}
