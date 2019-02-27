# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils libtool pam autotools

DESCRIPTION="Utilities to deal with user accounts"
HOMEPAGE="https://github.com/shadow-maint/shadow http://pkg-shadow.alioth.debian.org/"
SRC_URI="https://github.com/shadow-maint/shadow/releases/download/${PV}/${P}.tar.gz"
KEYWORDS="amd64 arm64"

LICENSE="BSD GPL-2"
SLOT="0"
IUSE="acl audit +cracklib pam selinux skey xattr"

RDEPEND="acl? ( sys-app/acl:0= )
	audit? ( >=sys-app/audit-2.6:0= )
	cracklib? ( >=lib-sys/cracklib-2.7-r3:0= )
	pam? ( lib-sys/pam:0= )
	skey? ( lib-sys/skey:0= )
	selinux? (
		>=lib-sys/libselinux-1.28:0=
		lib-sys/libsemanage:0=
	)
	xattr? ( sys-app/attr:0= )"
DEPEND="${RDEPEND}
	app-compression/xz-utils"

RDEPEND="${RDEPEND}
	pam? ( >=lib-sys/pambase-20150213 )"

PATCHES=(
			${FILESDIR}/01_73a876a05612c278da747faeaeea40c3b8d34a53.patch
			${FILESDIR}/02_48dcf7852e51b9d8e7926737cc7f7823978b7d7d.patch
			${FILESDIR}/03_b3b6d9d77c1d18b98670b97157777bb74092cd69.patch
			${FILESDIR}/05_2fd58155464fb4e753e8789c923aa640c1336127.patch
			${FILESDIR}/07_89b96cb85cbd86a3f07a47e5e6826f7c5a69e3d5.patch
			${FILESDIR}/10_4be18d32991e73c460ca59c43384f75419602a35.patch
		)

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--without-group-name-max-length
		--without-tcb
		--enable-shared=no
		--enable-static=yes
		$(use_with acl)
		$(use_with audit)
		$(use_with cracklib libcrack)
		$(use_with pam libpam)
		$(use_with skey)
		$(use_with selinux)
		$(use_with elibc_glibc nscd)
		$(use_with xattr attr)
	)
	econf ${myconf[@]}

	has_version 'lib-sys/uclibc[-rpc]' && sed -i '/RLOGIN/d' config.h #425052
}

set_login_opt() {
	local comment="" opt=$1 val=$2
	if [[ -z ${val} ]]; then
		comment="#"
		sed -i \
			-e "/^${opt}\>/s:^:#:" \
			"${ED}"/etc/login.defs || die
	else
		sed -i -r \
			-e "/^#?${opt}\>/s:.*:${opt} ${val}:" \
			"${ED}"/etc/login.defs
	fi
	local res=$(grep "^${comment}${opt}\>" "${ED}"/etc/login.defs)
	einfo "${res:-Unable to find ${opt} in /etc/login.defs}"
}

src_install() {
	emake DESTDIR="${D}" suidperms=4711 install

	# Remove libshadow and libmisc; internal use only
	rm -f "${ED}"/{,usr/}lib64/lib{misc,shadow}.{a,la}

	insinto /etc
	if ! use pam ; then
		insopts -m0600
		doins etc/login.access etc/limits
	fi

	# needed for 'useradd -D'
	insinto /etc/default
	insopts -m0600
	doins "${FILESDIR}"/default/useradd

	cd "${S}"
	insinto /etc
	insopts -m0644
	newins etc/login.defs login.defs

	set_login_opt CREATE_HOME yes
	if ! use pam ; then
		set_login_opt MAIL_CHECK_ENAB no
		set_login_opt SU_WHEEL_ONLY yes
		set_login_opt CRACKLIB_DICTPATH /usr/lib64/cracklib_dict
		set_login_opt LOGIN_RETRIES 3
		set_login_opt ENCRYPT_METHOD SHA512
		set_login_opt CONSOLE
	else
		dopamd "${FILESDIR}"/pam.d-include/shadow

		for x in chpasswd chgpasswd newusers; do
			newpamd "${FILESDIR}"/pam.d-include/passwd ${x}
		done

		for x in chage chsh chfn \
				 user{add,del,mod} group{add,del,mod} ; do
			newpamd "${FILESDIR}"/pam.d-include/shadow ${x}
		done

		# comment out login.defs options that pam hates
		local opt sed_args=()
		for opt in \
			CHFN_AUTH \
			CONSOLE \
			CRACKLIB_DICTPATH \
			ENV_HZ \
			ENVIRON_FILE \
			FAILLOG_ENAB \
			FTMP_FILE \
			LASTLOG_ENAB \
			MAIL_CHECK_ENAB \
			MOTD_FILE \
			NOLOGINS_FILE \
			OBSCURE_CHECKS_ENAB \
			PASS_ALWAYS_WARN \
			PASS_CHANGE_TRIES \
			PASS_MIN_LEN \
			PORTTIME_CHECKS_ENAB \
			QUOTAS_ENAB \
			SU_WHEEL_ONLY
		do
			set_login_opt ${opt}
			sed_args+=( -e "/^#${opt}\>/b pamnote" )
		done
		sed -i "${sed_args[@]}" \
			-e 'b exit' \
			-e ': pamnote; i# NOTE: This setting should be configured via /etc/pam.d/ and not in this file.' \
			-e ': exit' \
			"${ED}"/etc/login.defs || die

		# remove manpages that pam will install for us
		# and/or don't apply when using pam
		find "${ED}"/usr/share/man \
			'(' -name 'limits.5*' -o -name 'suauth.5*' ')' \
			-delete

		# Remove pam.d files provided by pambase.
		rm "${ED}"/etc/pam.d/{login,passwd,su} || die
	fi

	rm "${ED}"/usr/share/man/man1/passwd.1* || die
}

pkg_preinst() {
	rm -f "${EROOT}"/etc/pam.d/system-auth.new \
		"${EROOT}/etc/login.defs.new"
}

pkg_postinst() {
	# Enable shadow groups.
	if [ ! -f "${EROOT}"/etc/gshadow ] ; then
		if grpck -r -R "${EROOT}" 2>/dev/null ; then
			grpconv -R "${EROOT}"
		else
			ewarn "Running 'grpck' returned errors.  Please run it by hand, and then"
			ewarn "run 'grpconv' afterwards!"
		fi
	fi
}
