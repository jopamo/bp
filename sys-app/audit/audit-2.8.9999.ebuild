# Distributed under the terms of the GNU General Public License v2

EAPI="6"


inherit autotools toolchain-funcs preserve-libs python-r1 linux-info systemd git-r3 flag-o-matic

DESCRIPTION="Userspace utilities for storing and processing auditing records"
HOMEPAGE="https://people.redhat.com/sgrubb/audit/"
EGIT_REPO_URI="https://github.com/linux-audit/audit-userspace.git"
EGIT_BRANCH="$(ver_cut 1).$(ver_cut 2)_maintenance"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="gssapi ldap python static-libs"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
# Testcases are pretty useless as they are built for RedHat users/groups and kernels.
RESTRICT="test"

RDEPEND="gssapi? ( virtual/krb5 )
	ldap? ( net-nds/openldap )
	lib-sys/libcap-ng
	python? ( ${PYTHON_DEPS} )"
DEPEND="${RDEPEND}
	sys-kernel/linux-headers
	dev-lang/swig:0"

CONFIG_CHECK="~AUDIT"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

pkg_setup() {
	linux-info_pkg_setup
}

src_prepare() {
	eapply_user

	# Do not build GUI tools
	sed -i \
		-e '/AC_CONFIG_SUBDIRS.*system-config-audit/d' \
		"${S}"/configure.ac || die
	sed -i \
		-e 's,system-config-audit,,g' \
		"${S}"/Makefile.am || die
	rm -rf "${S}"/system-config-audit

	if ! use ldap; then
		sed -i \
			-e '/^AC_OUTPUT/s,audisp/plugins/zos-remote/Makefile,,g' \
			"${S}"/configure.ac || die
		sed -i \
			-e '/^SUBDIRS/s,zos-remote,,g' \
			"${S}"/audisp/plugins/Makefile.am || die
	fi

	# Don't build static version of Python module.
	eapply "${FILESDIR}"/${PN}-2.4.3-python.patch

	# there is no --without-golang conf option
	sed -e "/^SUBDIRS =/s/ @gobind_dir@//" -i bindings/Makefile.am || die

	# Regenerate autotooling
	eautoreconf
}

src_configure() {
	tc-export_build_env BUILD_{CC,CPP}
	export CC_FOR_BUILD="${BUILD_CC}"
	export CPP_FOR_BUILD="${BUILD_CPP}"

	local ECONF_SOURCE=${S}
	econf \
		--sbindir="${EPREFIX}/usr/sbin" \
		$(use_enable gssapi gssapi-krb5) \
		$(use_enable static-libs static) \
		$(use_enable ldap zos-remote) \
		--enable-systemd \
		--without-python \
		--without-python3

	python_configure() {
			mkdir -p "${BUILD_DIR}" || die
			cd "${BUILD_DIR}" || die

			if python_is_python3; then
				econf --without-python --with-python3
			else
				econf --with-python --without-python3
			fi
		}

		use python && python_foreach_impl python_configure
}

src_compile() {
	default

		python_compile() {
			local pysuffix pydef
			if python_is_python3; then
				pysuffix=3
				pydef='USE_PYTHON3=true'
			else
				pysuffix=2
				pydef='HAVE_PYTHON=true'
			fi

			emake -C "${BUILD_DIR}"/bindings/swig \
				VPATH="${native_build}/lib" \
				LIBS="${native_build}/lib/libaudit.la" \
				_audit_la_LIBADD="${native_build}/lib/libaudit.la" \
				_audit_la_DEPENDENCIES="${S}/lib/libaudit.h ${native_build}/lib/libaudit.la" \
				${pydef}
			emake -C "${BUILD_DIR}"/bindings/python/python${pysuffix} \
				VPATH="${S}/bindings/python/python${pysuffix}:${native_build}/bindings/python/python${pysuffix}" \
				auparse_la_LIBADD="${native_build}/auparse/libauparse.la ${native_build}/lib/libaudit.la" \
				${pydef}
		}

		local native_build="${BUILD_DIR}"
		use python && python_foreach_impl python_compile
}

src_install() {
	emake DESTDIR="${D}" initdir="$(systemd_get_systemunitdir)" install

		python_install() {
			local pysuffix pydef
			if python_is_python3; then
				pysuffix=3
				pydef='USE_PYTHON3=true'
			else
				pysuffix=2
				pydef='HAVE_PYTHON=true'
			fi

			emake -C "${BUILD_DIR}"/bindings/swig \
				VPATH="${native_build}/lib" \
				LIBS="${native_build}/lib/libaudit.la" \
				_audit_la_LIBADD="${native_build}/lib/libaudit.la" \
				_audit_la_DEPENDENCIES="${S}/lib/libaudit.h ${native_build}/lib/libaudit.la" \
				${pydef} \
				DESTDIR="${D}" install
			emake -C "${BUILD_DIR}"/bindings/python/python${pysuffix} \
				VPATH="${S}/bindings/python/python${pysuffix}:${native_build}/bindings/python/python${pysuffix}" \
				auparse_la_LIBADD="${native_build}/auparse/libauparse.la ${native_build}/lib/libaudit.la" \
				${pydef} \
				DESTDIR="${D}" install
		}

		local native_build=${BUILD_DIR}
		use python && python_foreach_impl python_install

	docinto contrib
	dodoc contrib/{avc_snap,skeleton.c}
	docinto contrib/plugin
	dodoc contrib/plugin/*
	docinto rules
	dodoc rules/*

	fperms 644 "$(systemd_get_systemunitdir)"/auditd.service # 556436

	# Gentoo rules
	insinto /etc/audit/
	newins "${FILESDIR}"/audit.rules-2.1.3 audit.rules
	doins "${FILESDIR}"/audit.rules.stop*

	# audit logs go here
	keepdir /var/log/audit/

	find "${D}" -name '*.la' -delete || die

	# Security
	lockdown_perms "${ED}"
}

pkg_postinst() {
	lockdown_perms "${EROOT}"
}

lockdown_perms() {
	# Upstream wants these to have restrictive perms.
	# Should not || die as not all paths may exist.
	local basedir="$1"
	chmod 0750 "${basedir}"/usr/sbin/au{ditctl,report,dispd,ditd,search,trace} 2>/dev/null
	chmod 0750 "${basedir}"/var/log/audit/ 2>/dev/null
	chmod 0640 "${basedir}"/etc/{audit/,}{auditd.conf,audit.rules*} 2>/dev/null
}
