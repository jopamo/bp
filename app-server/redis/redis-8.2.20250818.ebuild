# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="$(ver_cut 1-2)"
SNAPSHOT=cd0b12938b6c99978440c6f7e44e34d7ff0aa537

inherit autotools edo multiprocessing toolchain-funcs doins

DESCRIPTION="A persistent caching system, key-value, and data structures database"
HOMEPAGE="https://github.com/redis/redis"

SRC_URI="https://github.com/redis/redis/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="BSD Boost-1.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="jemalloc selinux ssl systemd test"

RESTRICT="!test? ( test )"

COMMON_DEPEND="
	jemalloc? ( lib-dev/jemalloc )
	ssl? ( virtual/ssl )
	systemd? ( app-core/systemd )
"

RDEPEND="${COMMON_DEPEND}"
BDEPEND="${COMMON_DEPEND}"

DEPEND="
	${COMMON_DEPEND}
	test? ( app-lang/tcl )"

REQUIRED_USE="?? ( jemalloc )"

PATCHES=(
	"${FILESDIR}"/${PN}-6.2.1-config.patch
	"${FILESDIR}"/${PN}-7.2.0-system-jemalloc.patch
	"${FILESDIR}"/${PN}-6.2.3-ppc-atomic.patch
	"${FILESDIR}"/${PN}-sentinel-7.2.0-config.patch
	"${FILESDIR}"/${PN}-7.0.4-no-which.patch
)

src_prepare() {
	default

	# Respect user CFLAGS in bundled lua
	sed -i '/LUA_CFLAGS/s: -O2::g' deps/Makefile || die

	# now we will rewrite present Makefiles
	local makefiles="" MKF
	local mysedconf=(
		-e 's:$(CC):@CC@:g'
		-e 's:$(CFLAGS):@AM_CFLAGS@:g'
		-e 's: $(DEBUG)::g'

		-e 's:-Werror ::g'
		-e 's:-Werror=deprecated-declarations ::g'
	)
	for MKF in $(find -name 'Makefile' | cut -b 3-); do
		mv "${MKF}" "${MKF}.in"
		sed -i "${mysedconf[@]}" "${MKF}.in" || die "Sed failed for ${MKF}"
		makefiles+=" ${MKF}"
	done
	# autodetection of compiler and settings; generates the modified Makefiles
	cp "${FILESDIR}"/configure.ac-7.0 configure.ac || die

	sed -i \
		-e "/^AC_INIT/s|, __PV__, |, $PV, |" \
		-e "s:AC_CONFIG_FILES(\[Makefile\]):AC_CONFIG_FILES([${makefiles}]):g" \
		configure.ac || die "Sed failed for configure.ac"
	eautoreconf
}

src_configure() {
	econf

	# Linenoise can't be built with -std=c99, see https://bugs.gentoo.org/451164
	# also, don't define ANSI/c99 for lua twice
	sed -i -e "s:-std=c99::g" deps/linenoise/Makefile deps/Makefile || die
}

src_compile() {
	tc-export AR CC RANLIB

	local myconf=(
		AR="${AR}"
		CC="${CC}"
		RANLIB="${RANLIB}"

		V=1 # verbose

		# OPTIMIZATION defaults to -O3. Let's respect user CFLAGS by setting it
		# to empty value.
		OPTIMIZATION=''
		# Disable debug flags in bundled hiredis
		DEBUG_FLAGS=''

		BUILD_TLS=$(usex ssl)
		USE_SYSTEMD=$(usex systemd)
	)

	if use jemalloc; then
		myconf+=( MALLOC=jemalloc )
	else
		myconf+=( MALLOC=libc )
	fi

	emake "${myconf[@]}"
}

src_test() {
	local runtestargs=(
		--clients "$(makeopts_jobs)" # see bug #649868

		--skiptest "Active defrag eval scripts" # see bug #851654
	)

	if has usersandbox ${FEATURES} || ! has userpriv ${FEATURES}; then
		ewarn "oom-score-adj related tests will be skipped." \
			"They are known to fail with FEATURES usersandbox or -userpriv. See bug #756382."

		runtestargs+=(
			# unit/oom-score-adj was introduced in version 6.2.0
			--skipunit unit/oom-score-adj # see bug #756382

			# Following test was added in version 7.0.0 to unit/introspection.
			# It also tries to adjust OOM score.
			--skiptest "CONFIG SET rollback on apply error"
		)
	fi

	if use ssl; then
		edo ./utils/gen-test-certs.sh
		runtestargs+=( --tls )
	fi

	edo ./runtest "${runtestargs[@]}"
}

src_install() {
	insinto /etc/redis
	doins redis.conf sentinel.conf

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/redis.service"
	fi

	newtmpfiles "${FILESDIR}/${PN}-tmpfiles" ${PN}.conf

	insinto /etc/logrotate.d/
	newins "${FILESDIR}/${PN}.logrotate" ${PN}

	dodoc 00-RELEASENOTES BUGS CONTRIBUTING.md MANIFESTO README.md

	dobin src/redis-cli
	dobin src/redis-benchmark src/redis-server src/redis-check-aof src/redis-check-rdb
	fperms 0750 /usr/bin/redis-benchmark
	dosym redis-server /usr/bin/redis-sentinel
}

pkg_preinst() {
	enewgroup redis 6379
	enewuser redis 6379 -1 -1 redis
}

pkg_postinst() {
	sysusers_process
	tmpfiles_process
}
