# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic multiprocessing python-r1 toolchain-funcs

MY_P="${PN}_$(ver_rs 1- _)"
MAJOR_V="$(ver_cut 1-2)"

DESCRIPTION="Boost Libraries for C++"
HOMEPAGE="http://www.boost.org/"
SRC_URI="https://downloads.sourceforge.net/project/boost/${PN}/${PV}/${MY_P}.tar.bz2"

LICENSE="Boost-1.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

IUSE="context debug doc icu +nls mpi python static-libs +threads tools bzip2 zlib lzma zstd"

RDEPEND="icu? ( >=lib-dev/icu-3.6:= )
	mpi? ( >=virtual/mpi-2.0-r4[cxx,threads] )
	bzip2? ( app-compression/bzip2 )
	zlib? ( lib-sys/zlib )
	lzma? ( app-compression/xz-utils )
	zstd? ( app-compression/zstd )
	python? ( ${PYTHON_DEPS} )
	app-compression/bzip2
	lib-sys/zlib
	!app-admin/eselect-boost"
DEPEND="${RDEPEND}
	=lib-dev/boost-build-${MAJOR_V}*"
REQUIRED_USE="
	mpi? ( threads )
	python? ( ${PYTHON_REQUIRED_USE} )"

S="${WORKDIR}/${MY_P}"

RESTRICT="test"

PATCHES=(
	"${FILESDIR}/${PN}-1.48.0-disable_icu_rpath.patch"
	"${FILESDIR}/${PN}-1.56.0-build-auto_index-tool.patch"
)

pkg_setup() {
	# Bail out on unsupported build configuration, bug #456792
	if [[ -f "${EROOT%/}/etc/site-config.jam" ]]; then
		grep -q trelease "${EROOT%/}/etc/site-config.jam" && grep -q tdebug "${EROOT%/}/etc/site-config.jam" ||
		(
			eerror "You are using custom ${EROOT%/}/etc/site-config.jam without defined trelease/tdebug targets."
			eerror "Boost can not be built in such configuration."
			eerror "Please, either remove this file or add targets from ${EROOT%/}/usr/share/boost-build/site-config.jam to it."
			die
		)
	fi
}

src_prepare() {
	default

	# Do not try to build missing 'wave' tool, bug #522682
	# Upstream bugreport - https://svn.boost.org/trac/boost/ticket/10507
	sed -i -e 's:wave/build//wave::' tools/Jamfile.v2 || die
}

ejam() {
	local b2_opts=(
		"$@"
	)
	echo b2 "${b2_opts[@]}"
	b2 "${b2_opts[@]}"
}

src_configure() {
	# Workaround for too many parallel processes requested, bug #506064
	[[ "$(makeopts_jobs)" -gt 64 ]] && MAKEOPTS="${MAKEOPTS} -j64"

	OPTIONS=(
		$(usex debug tdebug trelease)
		"-j$(makeopts_jobs)"
		-q
		-d+2
	)

	# Use C++14 globally as of 1.62
	append-cxxflags -std=c++14

	use icu && OPTIONS+=(
			"-sICU_PATH=${EPREFIX}/usr"
		)
	use icu || OPTIONS+=(
			--disable-icu
			boost.locale.icu=off
		)
	use mpi || OPTIONS+=(
			--without-mpi
		)
	use nls || OPTIONS+=(
			--without-locale
		)
	use context || OPTIONS+=(
			--without-context
			--without-coroutine
			--without-fiber
		)
	use threads || OPTIONS+=(
			--without-thread
		)

	OPTIONS+=(
		pch=off
		--boost-build="${EPREFIX}"/usr/share/boost-build
		--prefix="${ED%/}/usr"
		--layout=system
		# building with threading=single is currently not possible
		# https://svn.boost.org/trac/boost/ticket/7105
		threading=multi
		link=$(usex static-libs shared,static shared)
	)

	use bzip2 || OPTIONS+=(
			-sNO_BZIP2=1
		)
	use zlib || OPTIONS+=(
			-sNO_ZLIB=1
		)
	use lzma || OPTIONS+=(
			-sNO_LZMA=1
		)
	use zstd || OPTIONS+=(
			-sNO_ZSTD=1
		)
}

src_compile() {
	local -x BOOST_ROOT="${BUILD_DIR}"
	PYTHON_DIRS=""
	MPI_PYTHON_MODULE=""

	building() {
		local PYTHON_OPTIONS
		if use python; then
			PYTHON_OPTIONS=" --python-buildid=${EPYTHON#python}"
		else
			PYTHON_OPTIONS=" --without-python"
		fi

		ejam \
			"${OPTIONS[@]}" \
			${PYTHON_OPTIONS} \
			|| die "Building of Boost libraries failed"

		if use python; then
			if [[ -z "${PYTHON_DIRS}" ]]; then
				PYTHON_DIRS="$(find bin.v2/libs -name python | sort)"
			else
				if [[ "${PYTHON_DIRS}" != "$(find bin.v2/libs -name python | sort)" ]]; then
					die "Inconsistent structure of build directories"
				fi
			fi

			local dir
			for dir in ${PYTHON_DIRS}; do
				mv ${dir} ${dir}-${EPYTHON} \
					|| die "Renaming of '${dir}' to '${dir}-${EPYTHON}' failed"
			done
		fi
	}
	if use python; then
		python_foreach_impl building
	else
		building
	fi

	if use tools; then
		pushd tools >/dev/null || die

		ejam \
			"${OPTIONS[@]}" \
			${PYTHON_OPTIONS} \
			|| die "Building of Boost tools failed"
		popd >/dev/null || die
	fi
}

src_install() {
	local -x BOOST_ROOT="${BUILD_DIR}"
	installation() {
		local PYTHON_OPTIONS
		if use python; then
			local dir
			for dir in ${PYTHON_DIRS}; do
				cp -pr ${dir}-${EPYTHON} ${dir} \
					|| die "Copying of '${dir}-${EPYTHON}' to '${dir}' failed"
			done

			if use mpi; then
				cp -p stage/lib/mpi.so-${EPYTHON} "${MPI_PYTHON_MODULE}" \
					|| die "Copying of 'stage/lib/mpi.so-${EPYTHON}' to '${MPI_PYTHON_MODULE}' failed"
				cp -p stage/lib/mpi.so-${EPYTHON} stage/lib/mpi.so \
					|| die "Copying of 'stage/lib/mpi.so-${EPYTHON}' to 'stage/lib/mpi.so' failed"
			fi
			PYTHON_OPTIONS=" --python-buildid=${EPYTHON#python}"
		else
			PYTHON_OPTIONS=" --without-python"
		fi

		ejam \
			"${OPTIONS[@]}" \
			${PYTHON_OPTIONS} \
			--includedir="${ED%/}/usr/include" \
			--libdir="${ED%/}/usr/lib" \
			install || die "Installation of Boost libraries failed"

		if use python; then
			rm -r ${PYTHON_DIRS} || die

			# Move mpi.so Python module to Python site-packages directory.
			# https://svn.boost.org/trac/boost/ticket/2838
			if use mpi; then
				local moddir=$(python_get_sitedir)/boost
				# moddir already includes eprefix
				mkdir -p "${D}${moddir}" || die
				mv "${ED%/}/usr/lib/mpi.so" "${D}${moddir}" || die
				cat << EOF > "${D}${moddir}/__init__.py" || die
import sys
if sys.platform.startswith('linux'):
	import DLFCN
	flags = sys.getdlopenflags()
	sys.setdlopenflags(DLFCN.RTLD_NOW | DLFCN.RTLD_GLOBAL)
	from . import mpi
	sys.setdlopenflags(flags)
	del DLFCN, flags
else:
	from . import mpi
del sys
EOF
			fi

			python_optimize
		fi
	}
	if use python; then
		python_foreach_impl installation
	else
		installation
	fi

	if use tools; then
		dobin dist/bin/*

		insinto /usr/share
		doins -r dist/share/boostbook
	fi

	if ! use python; then
		rm -r "${ED%/}"/usr/include/boost/python* || die
	fi

	if ! use nls; then
		rm -r "${ED%/}"/usr/include/boost/locale || die
	fi

	if ! use context; then
		rm -r "${ED%/}"/usr/include/boost/context || die
		rm -r "${ED%/}"/usr/include/boost/coroutine{,2} || die
		rm "${ED%/}"/usr/include/boost/asio/spawn.hpp || die
	fi

	if use doc; then
		# find extraneous files that shouldn't be installed
		# as part of the documentation and remove them.
		find libs/*/* \( -iname 'test' -o -iname 'src' \) -exec rm -rf '{}' + || die
		find doc \( -name 'Jamfile.v2' -o -name 'build' -o -name '*.manifest' \) -exec rm -rf '{}' + || die
		find tools \( -name 'Jamfile.v2' -o -name 'src' -o -name '*.cpp' -o -name '*.hpp' \) -exec rm -rf '{}' + || die

		docinto html
		dodoc *.{htm,html,png,css}
		dodoc -r doc libs more tools

		# To avoid broken links
		dodoc LICENSE_1_0.txt

		dosym ../../../../include/boost /usr/share/doc/${PF}/html/boost
	fi

	use static-libs || find "${ED}" -name '*.a' -delete
}

pkg_preinst() {
	# Yai for having symlinks that are nigh-impossible to remove without
	# resorting to dirty hacks like these. Removes lingering symlinks
	# from the slotted versions.
	local symlink
	for symlink in "${EROOT%/}/usr/include/boost" "${EROOT%/}/usr/share/boostbook"; do
		if [[ -L ${symlink} ]]; then
			rm -f "${symlink}" || die
		fi
	done

	# some ancient installs still have boost cruft lying around
	# for unknown reasons, causing havoc for reverse dependencies
	# Bug: 607734
	rm -rf "${EROOT%/}"/usr/include/boost-1_[3-5]? || die
}
