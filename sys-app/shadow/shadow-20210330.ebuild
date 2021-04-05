# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=7cfe134090957d2127a5e2a13fa2e0c55c4e4a97

inherit autotools flag-o-matic

DESCRIPTION="Utilities to deal with user accounts"
HOMEPAGE="https://github.com/shadow-maint/shadow http://pkg-shadow.alioth.debian.org/"
SRC_URI="https://github.com/shadow-maint/shadow/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl audit pam skey systemd xattr"

DEPEND="
	app-compression/xz-utils
	acl? ( sys-app/acl:0= )
	audit? ( >=sys-app/audit-2.6:0= )
	pam? ( lib-sys/pam:0= )
	skey? ( lib-sys/skey:0= )
	xattr? ( sys-app/attr:0= )
"

filter-flags -Wl,-z,defs

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--without-group-name-max-length
		--without-tcb
		--disable-account-tools-setuid
		$(use_with acl)
		$(use_with audit)
		$(use_with skey)
		$(use_with pam libpam)
		$(use_with xattr attr)
	)
	econf ${myconf[@]}
}

src_install() {
	default

	insinto /etc/default
	insopts -m0600
	doins "${FILESDIR}"/useradd

	if use systemd; then
		insinto usr/lib/systemd/system
		insopts -m0644
		doins "${FILESDIR}/shadow.timer"
		doins "${FILESDIR}/shadow.service"
		install -d -m755 "${ED}/usr/lib/systemd/system/timers.target.wants"
		ln -s ../shadow.timer "${ED}/usr/lib/systemd/system/timers.target.wants/shadow.timer"
	fi

	insinto /etc
	insopts -m0644
	doins "${FILESDIR}/login.defs"

	if use pam; then
		rm "${ED}/etc/pam.d"/*
		insinto /etc/pam.d
		insopts -m0644
		doins "${FILESDIR}"/{passwd,chgpasswd,chpasswd,newusers}
		doins etc/pam.d/groupmems

		for file in chage groupadd groupdel groupmod shadow useradd usermod userdel; do
			newins "${FILESDIR}/defaults.pam" "$file"
		done
	fi

	rm "${ED}"/usr/sbin/logoutd || die
	rm \
			"${ED}"/usr/bin/{login,su,chsh,chfn,sg} \
			"${ED}"/usr/sbin/{nologin,vipw,vigr} || die

	# but we keep newgrp, as sg is really an alias to it
	mv "${ED}"/usr/bin/{newgrp,sg} || die

	cleanup_install
}
