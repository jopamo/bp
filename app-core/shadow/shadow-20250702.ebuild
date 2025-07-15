# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Utilities to deal with user accounts"
HOMEPAGE="https://github.com/shadow-maint/shadow http://pkg-shadow.alioth.debian.org/"
SNAPSHOT=36debf3ccfa33ea9f3b0e562a133a22d1bdc87bd
SRC_URI="https://github.com/shadow-maint/shadow/archive/${SNAPSHOT}.tar.gz -> shadow-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/shadow-${SNAPSHOT}"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl pam systemd xattr yescrypt"

DEPEND="
	app-compression/xz-utils
	lib-dev/libbsd
	lib-core/libxcrypt
	acl? ( app-core/acl )
	pam? ( lib-core/pam )
	xattr? ( app-core/attr )
"

src_prepare() {
	cp -rp "${FILESDIR}"/* "${S}"/

	sed -i 's|/sbin|/bin|g' src/Makefile.am || die

	default
	eautoreconf

	sed -i 's|/sbin|/bin|g' configure.ac || die
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/bin
		$(use_enable systemd logind)
		$(use_with acl)
		$(use_with pam libpam)
		$(use_with xattr attr)
		$(use_with yescrypt)
		--disable-account-tools-setuid
		--disable-nls
		--disable-static
		--enable-lastlog
		--with-bcrypt
		--with-btrfs
		--with-libbsd
		--without-audit
		--without-group-name-max-length
		--without-nscd
		--without-selinux
		--without-skey
		--without-tcb
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

	rm "${ED}"/usr/bin/logoutd || die
	rm \
			"${ED}"/usr/bin/{login,su,chsh,chfn,sg} \
			"${ED}"/usr/bin/{nologin,vipw,vigr} || die

	# but we keep newgrp, as sg is really an alias to it
	mv "${ED}"/usr/bin/{newgrp,sg} || die

	cleanup_install
}
