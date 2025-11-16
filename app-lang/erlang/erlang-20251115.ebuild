# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="maint"

inherit autotools flag-o-matic doins toolchain-funcs

DESCRIPTION="Erlang programming language, runtime environment and libraries (OTP)"
HOMEPAGE="https://www.erlang.org/ https://github.com/erlang/otp"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/erlang/otp.git"
	EGIT_BRANCH="$(ver_cut 1-2)"
	inherit git-r3
else
SNAPSHOT=13eb0c52f42498167d12cdf241bb02b5737e5ee0
	SRC_URI="https://github.com/erlang/otp/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S=${WORKDIR}/otp-${SNAPSHOT}
fi

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="java kpoll odbc sctp ssl systemd tk wxwidgets"

PATCHES=(
	"${FILESDIR}"/erlang-27.0-dont-ignore-LDFLAGS.patch
	"${FILESDIR}"/erlang-24.0.2-serial-configure.patch
	"${FILESDIR}"/erlang-25.1.2-c99.patch # Bug #882887
	"${FILESDIR}"/erlang-26.2.4-test-errorinfo.patch
)

SITEFILE=50"erlang"-gentoo.el

QA_CONFIG_IMPL_DECL_SKIP=(
	# FreeBSD & OpenBSD
	pthread_set_name_np
)

src_prepare() {
	default

	tc-export AR CPP CXX LD

	# bug #797886: erlang's VM does unsafe casts for ints
	# to pointers and back. This breaks on gcc-11 -flto.
	append-flags -fno-strict-aliasing

	filter-flags -flto*

	# Ensure that we use erl_interface's libei.a, and not the system
	# libei.so from dev-libs/libei. Bug #912888.
	sed -i 's/-lei$/-l:libei.a/' \
		"${S}"/lib/odbc/c_src/Makefile.in || die
	(cd "${S}"/lib/odbc &&
		 eautoconf -B "${S}"/make/autoconf &&
		 eautoheader -B "${S}"/make/autoconf) || die
}

src_configure() {
	use wxwidgets && setup-wxwidgets

	local myconf=(
		--disable-builtin-zlib

		# don't search for static zlib
		--with-ssl-zlib=no

		$(use_enable kpoll kernel-poll)
		$(use_with java javac)
		$(use_with odbc)
		$(use_enable sctp)
		$(use_with ssl ssl)
		$(use_enable ssl dynamic-ssl-lib)
		$(use_enable systemd)
		$(usex wxwidgets "--with-wx-config=${WX_CONFIG}" "--with-wxdir=/dev/null")
	)
	econf "${myconf[@]}"
}

extract_version() {
	local path="$1"
	local var_name="$2"
	sed -n -e "/^${var_name} = \(.*\)$/s::\1:p" "${S}/${path}/vsn.mk" || die "extract_version() failed"
}

src_install() {
	local erl_libdir_rel="$(get_libdir)/erlang"
	local erl_libdir="/usr/${erl_libdir_rel}"
	local erl_interface_ver="$(extract_version lib/erl_interface EI_VSN)"
	local erl_erts_ver="$(extract_version erts VSN)"
	local my_manpath="/usr/share/erlang/man"

	[[ -z "${erl_erts_ver}" ]] && die "Couldn't determine erts version"
	[[ -z "${erl_interface_ver}" ]] && die "Couldn't determine interface version"

	emake INSTALL_PREFIX="${D}" install

	dosym "../${erl_libdir_rel}/bin/erl" /usr/bin/erl
	dosym "../${erl_libdir_rel}/bin/erlc" /usr/bin/erlc
	dosym "../${erl_libdir_rel}/bin/escript" /usr/bin/escript
	dosym "../${erl_libdir_rel}/lib/erl_interface-${erl_interface_ver}/bin/erl_call" /usr/bin/erl_call
	dosym "../${erl_libdir_rel}/erts-${erl_erts_ver}/bin/beam.smp" /usr/bin/beam.smp

	rm "${ED}/${erl_libdir}/Install" || die

	docompress "${my_manpath}"

	insinto "${my_manpath}"
	doins -r "${WORKDIR}"/man/*
	# extend MANPATH, so the normal man command can find it
	# see bug 189639
	newenvd - "90erlang" <<-_EOF_
		MANPATH="${my_manpath}"
	_EOF_

	use systemd && systemd_newunit "${FILESDIR}"/epmd.service-r1 epmd.service
}

src_test() {
	# Only run a subset of tests to test that everything was built
	# successfully, otherwise we will be here for a long time.
	emake kernel_test ARGS="-suite os_SUITE"
}
