# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Enhanced mailx-compatible mail client based on Heirloom mailx (nail)"
HOMEPAGE="https://www.sdaoden.eu/code.html"
SRC_URI="https://ftp.sdaoden.eu/${P}.tar.xz"

LICENSE="BSD BSD-4 ISC RSA"
SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	local confopts=(
		strip="${BROOT}"/usr/bin/true
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

	dosym -r /usr/bin/s-nail /usr/bin/mailx
	dosym -r /usr/bin/mailx /usr/bin/mail
	dosym -r /usr/bin/mailx /usr/bin/Mail

	dosym -r /usr/share/man/man1/s-nail.1 /usr/share/man/man1/mailx.1
	dosym -r /usr/share/man/man1/mailx.1 /usr/share/man/man1/mail.1
	dosym -r /usr/share/man/man1/mailx.1 /usr/share/man/man1/Mail.1
}
