# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Linux PAM (Pluggable Authentication Modules for Linux) project"
HOMEPAGE="https://github.com/linux-pam/linux-pam"
SNAPSHOT=e3b66a60e4209e019cf6a45f521858cec2dbefa1
SRC_URI="https://github.com/linux-pam/linux-pam/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/linux-pam-${SNAPSHOT}

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="logind"

BDEPEND="
	app-build/flex
	app-tex/docbook-sgml-dtd
	app-tex/docbook-xml-dtd
"

DEPEND="lib-net/libtirpc"
PDEPEND="app-core/pambase"

src_configure() {
	local emesonargs=(
    	# i18n (feature: i18n support)
    	-Di18n=disabled

    	# docs (feature: generate and install documentation)
    	-Ddocs=disabled

    	# audit (feature: enable/disable audit support)
    	-Daudit=disabled

    	# econf (feature: use libeconf for config parsing)
    	-Deconf=disabled

    	# logind (feature: logind support via systemd)
    	-Dlogind=auto

    	# elogind (feature: logind support via elogind, for non-systemd systems)
    	-Delogind=disabled

    	# openssl (feature: use OpenSSL crypto in pam_timestamp)
    	-Dopenssl=enabled

    	# selinux (feature: enable SELinux support)
    	-Dselinux=disabled

    	# nis (feature: enable NIS/YP support in pam_unix)
    	-Dnis=disabled

    	# examples (boolean: build example programs)
    	-Dexamples=false

    	# lckpwdf (boolean: use lckpwdf lock in pam_unix)
    	-Dlckpwdf=true

    	# pam-debug (boolean: save debug info in pam-debug.log)
    	-Dpam-debug=false

    	# pamlocking (boolean: observe a global authentication lock)
    	-Dpamlocking=false

    	# read-both-confs (boolean: also read /etc/pam.conf alongside /etc/pam.d)
    	-Dread-both-confs=false

    	# usergroups (boolean: default to 'usergroups' option in pam_umask)
    	-Dusergroups=false

    	# xtests (boolean: build extra tests)
    	-Dxtests=false

    	# misc-conv-bufsize (integer: size of buffer for misc_conv() in pam_misc)
    	-Dmisc-conv-bufsize=4096

    	# kernel-overflow-uid (integer: UID for kernel overflow)
    	-Dkernel-overflow-uid=65534

    	# uidmin (integer: default minimum UID for normal users)
    	-Duidmin=1000

    	# docbook-rng (string: RNG file for validating DocBook XML)
    	-Ddocbook-rng='http://docbook.org/xml/5.0/rng/docbookxi.rng'

    	# html-stylesheet (string: XSL stylesheet path for generating HTML docs)
    	-Dhtml-stylesheet='http://docbook.sourceforge.net/release/xsl-ns/current/html/chunk.xsl'

    	# man-stylesheet (string: XSL stylesheet path for generating manual pages)
    	-Dman-stylesheet='http://docbook.sourceforge.net/release/xsl-ns/current/manpages/profile-docbook.xsl'

    	# pdf-stylesheet (string: XSL stylesheet path for generating PDF docs)
    	-Dpdf-stylesheet='http://docbook.sourceforge.net/release/xsl-ns/current/fo/docbook.xsl'

    	# txt-stylesheet (string: XSL stylesheet path for generating plain text docs)
    	-Dtxt-stylesheet='http://docbook.sourceforge.net/release/xsl-ns/current/html/docbook.xsl'

    	# xml-catalog (string: path to local XML catalog)
    	# -Dxml-catalog=...

    	# docdir (string: documentation directory)
    	# -Ddocdir=...

    	# htmldir (string: directory for generated HTML docs)
    	# -Dhtmldir=...

    	# pdfdir (string: directory for generated PDF docs)
    	# -Dpdfdir=...

    	# isadir (string: arch-specific modules directory under securedir)
    	# -Disadir=...

    	# securedir (string: where PAM modules are installed)
    	# -Dsecuredir="${EPREFIX}/usr/lib/security"

    	# sconfigdir (string: directory for PAM module-specific configuration)
    	# -Dsconfigdir=...

    	# systemdunitdir (string: where systemd .service/.unit files are placed)
    	# -Dsystemdunitdir=...

    	# mailspool (string: mail spool directory)
    	# -Dmailspool=...

    	# xauth (string: fallback path for xauth in pam_xauth)
    	# -Dxauth=...

    	# randomdev (string: alternative random device instead of /dev/urandom)
    	# -Drandomdev=...

    	# vendordir (string: distro-provided configuration files directory)
    	# -Dvendordir=...

    	# pam_userdb (feature: build the pam_userdb module)
    	-Dpam_userdb=auto

    	# db (combo: database backend for pam_userdb -- db, gdbm, ndbm, or auto)
    	-Ddb=auto

    	# db-uniquename (string: unique name for DB libraries/functions)
    	# -Ddb-uniquename=...

    	# pam_lastlog (feature: build the pam_lastlog module)
    	-Dpam_lastlog=enabled

    	# pam_unix (feature: build the pam_unix module)
    	-Dpam_unix=auto
	)



	meson_src_configure
}
