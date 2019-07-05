# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd flag-o-matic prefix toolchain-funcs user cmake-utils git-r3

HOMEPAGE="https://mariadb.org/"
DESCRIPTION="An enhanced, drop-in replacement for MySQL"
LICENSE="GPL-2 LGPL-2.1+"
EGIT_REPO_URI="https://github.com/MariaDB/server.git"
EGIT_BRANCH="$(ver_cut 1).$(ver_cut 2)"

SLOT="0/${SUBSLOT:-0}"
IUSE="backup bindist client-libs debug extraengine galera innodb-lz4
	innodb-lzo innodb-snappy jdbc jemalloc kerberos mroonga
	numa odbc oqgraph pam +perl profiling rocksdb +server sphinx
	sst-rsync sst-mariabackup sst-xtrabackup static static-libs systemd systemtap tcmalloc
	test tokudb xml yassl"

REQUIRED_USE="jdbc? ( extraengine server !static )
	server? ( tokudb? ( jemalloc !tcmalloc ) )
	?? ( tcmalloc jemalloc )
	static? ( yassl !pam )"

KEYWORDS="amd64 arm64"

COMMON_DEPEND="
	kernel_linux? (
		sys-app/procps:0=
		lib-dev/libaio:0=
	)
	>=sys-app/sed-4
	>=sys-devel/texinfo-4.7-r1
	jemalloc? ( lib-dev/jemalloc:0= )
	tcmalloc? ( dev-util/google-perftools:0= )
	systemtap? ( >=dev-util/systemtap-1.3:0= )
	>=lib-sys/zlib-1.2.3:0=
	yassl? ( lib-net/gnutls:0= )
	!yassl? ( >=lib-dev/openssl-1.0.0:0= )
	lib-sys/ncurses:0=
	!bindist? (
		>=lib-sys/readline-4.1:0=
	)
	server? (
		backup? ( app-compression/libarchive:0= )
		extraengine? (
			odbc? ( dev-db/unixODBC:0= )
			xml? ( lib-dev/libxml2:2= )
		)
		innodb-lz4? ( app-compression/lz4 )
		innodb-lzo? ( lib-dev/lzo )
		innodb-snappy? ( app-compression/snappy )
		numa? ( sys-app/numactl )
		oqgraph? ( >=lib-dev/boost-1.40.0:0= lib-dev/judy:0= )
		pam? ( lib-sys/pam:0= )
		systemd? ( sys-app/systemd:= )
		tokudb? ( app-compression/snappy )
	)
	>=lib-dev/libpcre-8.41-r1:3=
"

DEPEND="sys-devel/bison
	static? ( lib-sys/ncurses[static-libs] )
	|| ( >=sys-devel/gcc-3.4.6 >=sys-devel/gcc-apple-4.0 )
	${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}
	server? ( galera? (
		app-net/iproute2
		=sys-cluster/galera-25*
		sst-rsync? ( sys-app/lsof )
		sst-mariabackup? ( app-net/socat[ssl] )
		sst-xtrabackup? ( app-net/socat[ssl] )
	) )
"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro
append-cxxflags -felide-constructors
append-flags -fno-strict-aliasing -fPIC

pkg_setup() {
	enewgroup mysql 60 || die "problem adding 'mysql' group"
	enewuser mysql 60 -1 /dev/null mysql || die "problem adding 'mysql' user"
}

src_configure(){
	CMAKE_BUILD_TYPE="Release"

	mycmakeargs=(
		-DCMAKE_C_FLAGS_RELWITHDEBINFO="$(usex debug '' '-DNDEBUG')"
		-DCMAKE_CXX_FLAGS_RELWITHDEBINFO="$(usex debug '' '-DNDEBUG')"
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DMYSQL_DATADIR="${EPREFIX}/var/lib/mysql"
		-DSYSCONFDIR="${EPREFIX}/etc/mysql"
		-DINSTALL_BINDIR=bin
		-DINSTALL_DOCDIR=share/doc/${PF}
		-DINSTALL_DOCREADMEDIR=share/doc/${PF}
		-DINSTALL_INCLUDEDIR=include/mysql
		-DINSTALL_INFODIR=share/info
		-DINSTALL_LIBDIR=lib64
		-DINSTALL_MANDIR=share/man
		-DINSTALL_MYSQLSHAREDIR=share/mariadb
		-DINSTALL_PLUGINDIR=lib64/mariadb/plugin
		-DINSTALL_SCRIPTDIR=share/mariadb/scripts
		-DINSTALL_MYSQLDATADIR="${EPREFIX}/var/lib/mysql"
		-DINSTALL_SBINDIR=sbin
		-DINSTALL_SUPPORTFILESDIR="${EPREFIX}/usr/share/mariadb"
		-DWITH_UNIT_TESTS=$(usex test ON OFF)
		-DWITH_LIBEDIT=0
		-DWITH_ZLIB=system
		-DWITHOUT_LIBWRAP=1
		-DENABLED_LOCAL_INFILE=1
		-DMYSQL_UNIX_ADDR="${EPREFIX}/var/run/mysqld/mysqld.sock"
		-DINSTALL_UNIX_ADDRDIR="${EPREFIX}/var/run/mysqld/mysqld.sock"
		-DWITH_DEFAULT_COMPILER_OPTIONS=1
		-DWITH_DEFAULT_FEATURE_SET=1
		-DINSTALL_SYSTEMD_UNITDIR="$(systemd_get_systemunitdir)"
		# The build forces this to be defined when cross-compiling.  We pass it
		# all the time for simplicity and to make sure it is actually correct.
		-DSTACK_DIRECTION=$(tc-stack-grows-down && echo -1 || echo 1)
		-DPKG_CONFIG_EXECUTABLE="${EPREFIX}/usr/bin/$(tc-getPKG_CONFIG)"
		-DPLUGIN_AUTH_GSSAPI=$(usex kerberos DYNAMIC NO)
		-DAUTH_GSSAPI_PLUGIN_TYPE=$(usex kerberos DYNAMIC OFF)
		-DCONC_WITH_EXTERNAL_ZLIB=YES
		-DWITH_EXTERNAL_ZLIB=YES
		-DSUFFIX_INSTALL_DIR=""
		-DWITH_UNITTEST=OFF
		-DWITHOUT_CLIENTLIBS=YES
		-DCLIENT_PLUGIN_DIALOG=OFF
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=OFF
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DBUILD_CONFIG=mysql_release
	)
	if use test ; then
		mycmakeargs+=( -DINSTALL_MYSQLTESTDIR=share/mariadb/mysql-test )
	else
		mycmakeargs+=( -DINSTALL_MYSQLTESTDIR='' )
	fi

	if ! use yassl ; then
		mycmakeargs+=( -DWITH_SSL=system -DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC )
	else
		mycmakeargs+=( -DWITH_SSL=bundled )
	fi

	# bfd.h is only used starting with 10.1 and can be controlled by NOT_FOR_DISTRIBUTION
	mycmakeargs+=(
		-DWITH_READLINE=$(usex bindist 1 0)
		-DNOT_FOR_DISTRIBUTION=$(usex bindist 0 1)
		-DENABLE_DTRACE=$(usex systemtap)
	)

	if use server ; then

		# Federated{,X} must be treated special otherwise they will not be built as plugins
		if ! use extraengine ; then
			mycmakeargs+=(
				-DPLUGIN_FEDERATED=NO
				-DPLUGIN_FEDERATEDX=NO )
		fi

		mycmakeargs+=(
			-DWITH_JEMALLOC=$(usex jemalloc system)
			-DPLUGIN_OQGRAPH=$(usex oqgraph DYNAMIC NO)
			-DPLUGIN_SPHINX=$(usex sphinx YES NO)
			-DPLUGIN_TOKUDB=$(usex tokudb YES NO)
			-DPLUGIN_AUTH_PAM=$(usex pam YES NO)
			-DPLUGIN_CASSANDRA=NO
			-DPLUGIN_SEQUENCE=$(usex extraengine YES NO)
			-DPLUGIN_SPIDER=$(usex extraengine YES NO)
			-DPLUGIN_CONNECT=$(usex extraengine YES NO)
			-DCONNECT_WITH_MYSQL=1
			-DCONNECT_WITH_LIBXML2=$(usex xml)
			-DCONNECT_WITH_ODBC=$(usex odbc)
			-DCONNECT_WITH_JDBC=$(usex jdbc)
			# Build failure and autodep wrt bug 639144
			-DCONNECT_WITH_MONGO=OFF
			-DWITH_WSREP=$(usex galera)
			-DWITH_INNODB_LZ4=$(usex innodb-lz4 ON OFF)
			-DWITH_INNODB_LZO=$(usex innodb-lzo ON OFF)
			-DWITH_INNODB_SNAPPY=$(usex innodb-snappy ON OFF)
			-DPLUGIN_MROONGA=$(usex mroonga DYNAMIC NO)
			-DPLUGIN_AUTH_GSSAPI=$(usex kerberos DYNAMIC NO)
			-DWITH_MARIABACKUP=$(usex backup ON OFF)
			-DWITH_LIBARCHIVE=$(usex backup ON OFF)
			-DINSTALL_SQLBENCHDIR=""
			-DPLUGIN_ROCKSDB=$(usex rocksdb DYNAMIC NO)
			# systemd is only linked to for server notification
			-DWITH_SYSTEMD=$(usex systemd yes no)
			-DWITH_NUMA=$(usex numa ON OFF)
			-DDEFAULT_CHARSET=utf8
			-DDEFAULT_COLLATION=utf8_general_ci
			-DEXTRA_CHARSETS=all
			-DMYSQL_USER=mysql
			-DDISABLE_SHARED=$(usex static YES NO)
			-DWITH_DEBUG=$(usex debug)
			-DWITH_EMBEDDED_SERVER=OFF
			-DWITH_PROFILING=$(usex profiling)
			-DAWS_SDK_EXTERNAL_PROJECT=OFF
		)

		# Workaround for MDEV-14524
		use tokudb && mycmakeargs+=( -DTOKUDB_OK=1 )

		if use test ; then
			# This is needed for the new client lib which tests a real, open server
			mycmakeargs+=( -DSKIP_TESTS=ON )
		fi

		if use static; then
			mycmakeargs+=( -DWITH_PIC=1 )
		fi

		if use jemalloc || use tcmalloc ; then
			mycmakeargs+=( -DWITH_SAFEMALLOC=OFF )
		fi
	else
		mycmakeargs+=(
			-DWITHOUT_SERVER=1
			-DWITH_EMBEDDED_SERVER=OFF
			-DEXTRA_CHARSETS=none
			-DINSTALL_SQLBENCHDIR=
			-DWITH_SYSTEMD=no
		)
	fi

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install

	# Remove an unnecessary, private config header which will never match between ABIs and is not meant to be used
	if [[ -f "${ED}/usr/include/mysql/server/private/config.h" ]] ; then
		rm "${ED}/usr/include/mysql/server/private/config.h" || die
	fi

	# Make sure the vars are correctly initialized
	mysql_init_vars

	# Convenience links
	einfo "Making Convenience links for mysqlcheck multi-call binary"
	dosym "mysqlcheck" "/usr/bin/mysqlanalyze"
	dosym "mysqlcheck" "/usr/bin/mysqlrepair"
	dosym "mysqlcheck" "/usr/bin/mysqloptimize"

	# INSTALL_LAYOUT=STANDALONE causes cmake to create a /usr/data dir
	if [[ -d "${ED}/usr/data" ]] ; then
		rm -Rf "${ED}/usr/data" || die
	fi

	# Unless they explicitly specific USE=test, then do not install the
	# testsuite. It DOES have a use to be installed, esp. when you want to do a
	# validation of your database configuration after tuning it.
	if ! use test ; then
		rm -rf "${D}/${MY_SHAREDSTATEDIR}/mysql-test"
	fi

	# Configuration stuff
	einfo "Building default configuration ..."
	insinto "${MY_SYSCONFDIR#${EPREFIX}}"
	[[ -f "${S}/scripts/mysqlaccess.conf" ]] && doins "${S}"/scripts/mysqlaccess.conf
	cp "${FILESDIR}/my.cnf-10.2" "${TMPDIR}/my.cnf" || die
	eprefixify "${TMPDIR}/my.cnf"
	doins "${TMPDIR}/my.cnf"
	insinto "${MY_SYSCONFDIR#${EPREFIX}}/mariadb.d"
	cp "${FILESDIR}/my.cnf.distro-client" "${TMPDIR}/50-distro-client.cnf" || die
	eprefixify "${TMPDIR}/50-distro-client.cnf"
	doins "${TMPDIR}/50-distro-client.cnf"

	if use server ; then
		mycnf_src="my.cnf.distro-server"
		sed -e "s!@DATADIR@!${MY_DATADIR}!g" \
			"${FILESDIR}/${mycnf_src}" \
			> "${TMPDIR}/my.cnf.ok" || die
		if use prefix ; then
			sed -i -r -e '/^user[[:space:]]*=[[:space:]]*mysql$/d' \
				"${TMPDIR}/my.cnf.ok" || die
		fi

		eprefixify "${TMPDIR}/my.cnf.ok"
		newins "${TMPDIR}/my.cnf.ok" 50-distro-server.cnf

		einfo "Including support files and sample configurations"
		docinto "support-files"
		local script
		for script in \
			"${S}"/support-files/magic
		do
			[[ -f "$script" ]] && dodoc "${script}"
		done

		docinto "scripts"
		for script in "${S}"/scripts/mysql* ; do
			[[ ( -f "$script" ) && ( "${script%.sh}" == "${script}" ) ]] && dodoc "${script}"
		done
		# Manually install supporting files that conflict with other packages
		# but are needed for galera and initial installation
		exeinto /usr/libexec/mariadb
		doexe "${BUILD_DIR}/extra/my_print_defaults" "${BUILD_DIR}/extra/perror"
	fi

	#Remove mytop if perl is not selected
	[[ -e "${ED}/usr/bin/mytop" ]] && ! use perl && rm -f "${ED}/usr/bin/mytop"
}

# Official test instructions:
# USE='extraengine perl server' \
# FEATURES='test userpriv -usersandbox' \
# ebuild mariadb-X.X.XX.ebuild \
# digest clean package
src_test() {

	_disable_test() {
		local rawtestname reason
		rawtestname="${1}" ; shift
		reason="${@}"
		ewarn "test '${rawtestname}' disabled: '${reason}'"
		echo ${rawtestname} : ${reason} >> "${T}/disabled.def"
	}

	local TESTDIR="${BUILD_DIR}/mysql-test"
	local retstatus_unit
	local retstatus_tests

	if ! use server ; then
		einfo "Skipping server tests due to minimal build."
		return 0
	fi

	# Bug #213475 - MySQL _will_ object strenously if your machine is named
	# localhost. Also causes weird failures.
	[[ "${HOSTNAME}" == "localhost" ]] && die "Your machine must NOT be named localhost"

	if [[ $UID -eq 0 ]]; then
		die "Testing with FEATURES=-userpriv is no longer supported by upstream. Tests MUST be run as non-root."
	fi
	has usersandbox $FEATURES && ewarn "Some tests may fail with FEATURES=usersandbox"

	einfo ">>> Test phase [test]: ${CATEGORY}/${PF}"

	# Run CTest (test-units)
	cmake-utils_src_test
	retstatus_unit=$?

	# Ensure that parallel runs don't die
	export MTR_BUILD_THREAD="$((${RANDOM} % 100))"
	# Enable parallel testing, auto will try to detect number of cores
	# You may set this by hand.
	# The default maximum is 8 unless MTR_MAX_PARALLEL is increased
	export MTR_PARALLEL="${MTR_PARALLEL:-auto}"

	# create directories because mysqladmin might run out of order
	mkdir -p "${T}"/var-tests{,/log} || die

	# Run mysql tests
	pushd "${TESTDIR}" > /dev/null || die

	touch "${T}/disabled.def"
	# These are failing in MariaDB 10.0 for now and are believed to be
	# false positives:
	#
	# main.mysql_client_test, main.mysql_client_test_nonblock
	# main.mysql_client_test_comp:
	# segfaults at random under Portage only, suspect resource limits.

	local t
	for t in plugins.two_password_validations ; do
		_disable_test  "$t" "False positive due to varying policies"
	done

	for t in main.mysql_client_test main.mysql_client_test_nonblock \
		main.mysql_client_test_comp rpl.rpl_extra_col_master_myisam ; do
			_disable_test  "$t" "False positives in Gentoo"
	done

	_disable_test main.plugin_auth "Needs client libraries built"

	_disable_test main.func_time "Dependent on time test was written"

	# run mysql-test tests
	perl mysql-test-run.pl --force --vardir="${T}/var-tests" --reorder --skip-test=tokudb --skip-test-list="${T}/disabled.def"
	retstatus_tests=$?

	popd > /dev/null || die

	# Cleanup is important for these testcases.
	pkill -9 -f "${S}/ndb" 2>/dev/null
	pkill -9 -f "${S}/sql" 2>/dev/null

	local failures=""
	[[ $retstatus_unit -eq 0 ]] || failures="${failures} test-unit"
	[[ $retstatus_tests -eq 0 ]] || failures="${failures} tests"

	[[ -z "$failures" ]] || die "Test failures: $failures"
	einfo "Tests successfully completed"
}

mysql_init_vars() {
	MY_SHAREDSTATEDIR=${MY_SHAREDSTATEDIR="${EPREFIX}/usr/share/mariadb"}
	MY_SYSCONFDIR=${MY_SYSCONFDIR="${EPREFIX}/etc/mysql"}
	MY_LOCALSTATEDIR=${MY_LOCALSTATEDIR="${EPREFIX}/var/lib/mysql"}
	MY_LOGDIR=${MY_LOGDIR="${EPREFIX}/var/log/mysql"}

	if [[ -z "${MY_DATADIR}" ]] ; then
		MY_DATADIR=""
		if [[ -f "${MY_SYSCONFDIR}/my.cnf" ]] ; then
			MY_DATADIR=`"my_print_defaults" mysqld 2>/dev/null \
				| sed -ne '/datadir/s|^--datadir=||p' \
				| tail -n1`
			if [[ -z "${MY_DATADIR}" ]] ; then
				MY_DATADIR=`grep ^datadir "${MY_SYSCONFDIR}/my.cnf" \
				| sed -e 's/.*=\s*//' \
				| tail -n1`
			fi
		fi
		if [[ -z "${MY_DATADIR}" ]] ; then
			MY_DATADIR="${MY_LOCALSTATEDIR}"
			einfo "Using default MY_DATADIR"
		fi
		elog "MySQL MY_DATADIR is ${MY_DATADIR}"

		if [[ -z "${PREVIOUS_DATADIR}" ]] ; then
			if [[ -e "${MY_DATADIR}" ]] ; then
				# If you get this and you're wondering about it, see bug #207636
				elog "MySQL datadir found in ${MY_DATADIR}"
				elog "A new one will not be created."
				PREVIOUS_DATADIR="yes"
			else
				PREVIOUS_DATADIR="no"
			fi
			export PREVIOUS_DATADIR
		fi
	else
		if [[ ${EBUILD_PHASE} == "config" ]]; then
			local new_MY_DATADIR
			new_MY_DATADIR=`"my_print_defaults" mysqld 2>/dev/null \
				| sed -ne '/datadir/s|^--datadir=||p' \
				| tail -n1`

			if [[ ( -n "${new_MY_DATADIR}" ) && ( "${new_MY_DATADIR}" != "${MY_DATADIR}" ) ]]; then
				ewarn "MySQL MY_DATADIR has changed"
				ewarn "from ${MY_DATADIR}"
				ewarn "to ${new_MY_DATADIR}"
				MY_DATADIR="${new_MY_DATADIR}"
			fi
		fi
	fi

	export MY_SHAREDSTATEDIR MY_SYSCONFDIR
	export MY_LOCALSTATEDIR MY_LOGDIR
	export MY_DATADIR
}

pkg_config() {
	_getoptval() {
		local mypd="${EROOT}"/usr/bin/my_print_defaults
		local section="$1"
		local flag="--${2}="
		local extra_options="${3}"
		"${mypd}" $extra_options $section | sed -n "/^${flag}/s,${flag},,gp"
	}
	local old_MY_DATADIR="${MY_DATADIR}"
	local old_HOME="${HOME}"
	# my_print_defaults needs to read stuff in $HOME/.my.cnf
	export HOME=${EPREFIX}/root

	# Make sure the vars are correctly initialized
	mysql_init_vars

	[[ -z "${MY_DATADIR}" ]] && die "Sorry, unable to find MY_DATADIR"
	if [[ ! -x "${EROOT}/usr/sbin/mysqld" ]] ; then
		die "Minimal builds do NOT include the MySQL server"
	fi

	if [[ ( -n "${MY_DATADIR}" ) && ( "${MY_DATADIR}" != "${old_MY_DATADIR}" ) ]]; then
		local MY_DATADIR_s="${ROOT}/${MY_DATADIR}"
		MY_DATADIR_s="${MY_DATADIR_s%%/}"
		local old_MY_DATADIR_s="${ROOT}/${old_MY_DATADIR}"
		old_MY_DATADIR_s="${old_MY_DATADIR_s%%/}"

		if [[ ( -d "${old_MY_DATADIR_s}" ) && ( "${old_MY_DATADIR_s}" != / ) ]]; then
			if [[ -d "${MY_DATADIR_s}" ]]; then
				ewarn "Both ${old_MY_DATADIR_s} and ${MY_DATADIR_s} exist"
				ewarn "Attempting to use ${MY_DATADIR_s} and preserving ${old_MY_DATADIR_s}"
			else
				elog "Moving MY_DATADIR from ${old_MY_DATADIR_s} to ${MY_DATADIR_s}"
				mv --strip-trailing-slashes -T "${old_MY_DATADIR_s}" "${MY_DATADIR_s}" \
				|| die "Moving MY_DATADIR failed"
			fi
		else
			ewarn "Previous MY_DATADIR (${old_MY_DATADIR_s}) does not exist"
			if [[ -d "${MY_DATADIR_s}" ]]; then
				ewarn "Attempting to use ${MY_DATADIR_s}"
			else
				eerror "New MY_DATADIR (${MY_DATADIR_s}) does not exist"
				die "Configuration Failed! Please reinstall ${CATEGORY}/${PN}"
			fi
		fi
	fi

	local pwd1="a"
	local pwd2="b"
	local maxtry=15

	if [ -z "${MYSQL_ROOT_PASSWORD}" ]; then
		local tmp_mysqld_password_source=

		for tmp_mysqld_password_source in mysql client; do
			einfo "Trying to get password for mysql 'root' user from '${tmp_mysqld_password_source}' section ..."
			MYSQL_ROOT_PASSWORD="$(_getoptval "${tmp_mysqld_password_source}" password)"
			if [[ -n "${MYSQL_ROOT_PASSWORD}" ]]; then
				if [[ ${MYSQL_ROOT_PASSWORD} == *$'\n'* ]]; then
					ewarn "Ignoring password from '${tmp_mysqld_password_source}' section due to newline character (do you have multiple password options set?)!"
					MYSQL_ROOT_PASSWORD=
					continue
				fi

				einfo "Found password in '${tmp_mysqld_password_source}' section!"
				break
			fi
		done

		# Sometimes --show is required to display passwords in some implementations of my_print_defaults
		if [[ "${MYSQL_ROOT_PASSWORD}" == '*****' ]]; then
			MYSQL_ROOT_PASSWORD="$(_getoptval "${tmp_mysqld_password_source}" password --show)"
		fi

		unset tmp_mysqld_password_source
	fi
	MYSQL_TMPDIR="$(_getoptval mysqld tmpdir)"
	# These are dir+prefix
	MYSQL_RELAY_LOG="$(_getoptval mysqld relay-log)"
	MYSQL_RELAY_LOG=${MYSQL_RELAY_LOG%/*}
	MYSQL_LOG_BIN="$(_getoptval mysqld log-bin)"
	MYSQL_LOG_BIN=${MYSQL_LOG_BIN%/*}

	if [[ ! -d "${ROOT}/$MYSQL_TMPDIR" ]]; then
		einfo "Creating MySQL tmpdir $MYSQL_TMPDIR"
		install -d -m 770 -o mysql -g mysql "${EROOT}/$MYSQL_TMPDIR"
	fi
	if [[ ! -d "${ROOT}/$MYSQL_LOG_BIN" ]]; then
		einfo "Creating MySQL log-bin directory $MYSQL_LOG_BIN"
		install -d -m 770 -o mysql -g mysql "${EROOT}/$MYSQL_LOG_BIN"
	fi
	if [[ ! -d "${EROOT}/$MYSQL_RELAY_LOG" ]]; then
		einfo "Creating MySQL relay-log directory $MYSQL_RELAY_LOG"
		install -d -m 770 -o mysql -g mysql "${EROOT}/$MYSQL_RELAY_LOG"
	fi

	if [[ -d "${ROOT}/${MY_DATADIR}/mysql" ]] ; then
		ewarn "You have already a MySQL database in place."
		ewarn "(${ROOT}/${MY_DATADIR}/*)"
		ewarn "Please rename or delete it if you wish to replace it."
		die "MySQL database already exists!"
	fi

	# Bug #213475 - MySQL _will_ object strenously if your machine is named
	# localhost. Also causes weird failures.
	[[ "${HOSTNAME}" == "localhost" ]] && die "Your machine must NOT be named localhost"

	if [ -z "${MYSQL_ROOT_PASSWORD}" ]; then

		einfo "Please provide a password for the mysql 'root' user now"
		einfo "or through the ${HOME}/.my.cnf file."
		ewarn "Avoid [\"'\\_%] characters in the password"
		read -rsp "    >" pwd1 ; echo

		einfo "Retype the password"
		read -rsp "    >" pwd2 ; echo

		if [[ "x$pwd1" != "x$pwd2" ]] ; then
			die "Passwords are not the same"
		fi
		MYSQL_ROOT_PASSWORD="${pwd1}"
		unset pwd1 pwd2
	fi

	local options
	local sqltmp="$(emktemp)"

	# Fix bug 446200. Don't reference host my.cnf, needs to come first,
	# see https://bugs.mysql.com/bug.php?id=31312
	use prefix && options="${options} '--defaults-file=${MY_SYSCONFDIR}/my.cnf'"

	# Figure out which options we need to disable to do the setup
	local helpfile="${TMPDIR}/mysqld-help"
	"${EROOT}/usr/sbin/mysqld" --verbose --help >"${helpfile}" 2>/dev/null
	for opt in grant-tables host-cache name-resolve networking slave-start \
		federated ssl log-bin relay-log slow-query-log external-locking \
		log-slave-updates \
		; do
		optexp="--(skip-)?${opt}" optfull="--loose-skip-${opt}"
		egrep -sq -- "${optexp}" "${helpfile}" && options="${options} ${optfull}"
	done

	einfo "Creating the mysql database and setting proper permissions on it ..."

	# Now that /var/run is a tmpfs mount point, we need to ensure it exists before using it
	PID_DIR="${EROOT}/var/run/mysqld"
	if [[ ! -d "${PID_DIR}" ]]; then
		install -d -m 755 -o mysql -g mysql "${PID_DIR}" || die "Could not create pid directory"
	fi

	if [[ ! -d "${MY_DATADIR}" ]]; then
		install -d -m 750 -o mysql -g mysql "${MY_DATADIR}" || die "Could not create data directory"
	fi

	pushd "${TMPDIR}" &>/dev/null || die

	# Filling timezones, see
	# https://dev.mysql.com/doc/mysql/en/time-zone-support.html
	"${EROOT}/usr/bin/mysql_tzinfo_to_sql" "${EROOT}/usr/share/zoneinfo" > "${sqltmp}" 2>/dev/null

	local cmd=( "${EROOT}/usr/share/mariadb/scripts/mysql_install_db" )
	[[ -f "${cmd}" ]] || cmd=( "${EROOT}/usr/bin/mysql_install_db" )
	cmd+=( "--basedir=${EPREFIX}/usr" ${options} "--datadir=${ROOT}/${MY_DATADIR}" "--tmpdir=${ROOT}/${MYSQL_TMPDIR}" )
	einfo "Command: ${cmd[*]}"
	su -s /bin/sh -c "${cmd[*]}" mysql \
		>"${TMPDIR}"/mysql_install_db.log 2>&1
	if [ $? -ne 0 ]; then
		grep -B5 -A999 -i "ERROR" "${TMPDIR}"/mysql_install_db.log 1>&2
		die "Failed to initialize mysqld. Please review ${EPREFIX}/var/log/mysql/mysqld.err AND ${TMPDIR}/mysql_install_db.log"
	fi
	popd &>/dev/null || die
	[[ -f "${ROOT}/${MY_DATADIR}/mysql/user.frm" ]] \
	|| die "MySQL databases not installed"

	use prefix || options="${options} --user=mysql"

	local socket="${EROOT}/var/run/mysqld/mysqld${RANDOM}.sock"
	local pidfile="${EROOT}/var/run/mysqld/mysqld${RANDOM}.pid"
	local mysqld="${EROOT}/usr/sbin/mysqld \
		${options} \
		--log-warnings=0 \
		--basedir=${EROOT}/usr \
		--datadir=${ROOT}/${MY_DATADIR} \
		--max_allowed_packet=8M \
		--net_buffer_length=16K \
		--socket=${socket} \
		--pid-file=${pidfile}
		--tmpdir=${ROOT}/${MYSQL_TMPDIR}"
	#einfo "About to start mysqld: ${mysqld}"
	ebegin "Starting mysqld"
	einfo "Command ${mysqld}"
	${mysqld} &
	rc=$?
	while ! [[ -S "${socket}" || "${maxtry}" -lt 1 ]] ; do
		maxtry=$((${maxtry}-1))
		echo -n "."
		sleep 1
	done
	eend $rc

	if ! [[ -S "${socket}" ]]; then
		die "Completely failed to start up mysqld with: ${mysqld}"
	fi

	ebegin "Setting root password"
	# Do this from memory, as we don't want clear text passwords in temp files
	local sql="UPDATE mysql.user SET Password = PASSWORD('${MYSQL_ROOT_PASSWORD}') WHERE USER='root'; FLUSH PRIVILEGES"
	"${EROOT}/usr/bin/mysql" \
		"--socket=${socket}" \
		-hlocalhost \
		-e "${sql}"
	eend $?

	if [[ -n "${sqltmp}" ]] ; then
		ebegin "Loading \"zoneinfo\", this step may require a few seconds"
		"${EROOT}/usr/bin/mysql" \
			"--socket=${socket}" \
			-hlocalhost \
			-uroot \
			--password="${MYSQL_ROOT_PASSWORD}" \
			mysql < "${sqltmp}"
		rc=$?
		eend $?
		[[ $rc -ne 0 ]] && ewarn "Failed to load zoneinfo!"
	fi

	# Stop the server and cleanup
	einfo "Stopping the server ..."
	kill $(< "${pidfile}" )
	rm -f "${sqltmp}"
	wait %1
	einfo "Done"
}
