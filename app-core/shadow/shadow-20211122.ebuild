# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=3ff3cd9c782dc8e1ebaa8d87523b7a8e741d83bc

inherit autotools flag-o-matic

DESCRIPTION="Utilities to deal with user accounts"
HOMEPAGE="https://github.com/shadow-maint/shadow http://pkg-shadow.alioth.debian.org/"
SRC_URI="https://github.com/shadow-maint/shadow/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl pam skey subids systemd xattr yescrypt"

DEPEND="
	app-compression/xz-utils
	acl? ( app-core/acl )
	pam? ( lib-core/pam )
	skey? ( lib-core/skey )
	xattr? ( app-core/attr )
"

filter-flags -Wl,-z,defs

src_prepare() {
	cp -rp "${FILESDIR}"/* "${S}"/
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--with-group-name-max-length=32
		--without-tcb
		--disable-account-tools-setuid
		$(use_with acl)
		--without-audit
		$(use_with skey)
		$(use_enable subids subordinate-ids)
		$(use_with pam libpam)
		$(use_with xattr attr)
		$(use_with yescrypt)
	)
	econf ${myconf[@]}
}

src_install() {
	default

	insinto /etc/default
	insopts -m0600
	doins useradd

	if use systemd; then
		insinto usr/lib/systemd/system
		insopts -m0644
		doins shadow.timer
		doins shadow.service
		install -d -m755 "${ED}/usr/lib/systemd/system/timers.target.wants"
		ln -s ../shadow.timer "${ED}/usr/lib/systemd/system/timers.target.wants/shadow.timer"
	fi

	insinto /etc
	insopts -m0644
	doins login.defs

	if use pam; then
		use yescrypt && sed -i 's/sha512/yescrypt/g' {passwd,chpasswd,newusers}
		rm "${ED}/etc/pam.d"/*
		insinto /etc/pam.d
		insopts -m0644
		doins {passwd,chgpasswd,chpasswd,newusers}
		doins etc/pam.d/groupmems

		for file in chage groupadd groupdel groupmod shadow useradd usermod userdel; do
			newins defaults.pam "$file"
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
