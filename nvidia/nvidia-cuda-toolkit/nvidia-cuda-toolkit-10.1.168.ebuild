# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cuda toolchain-funcs unpacker

MYD=$(ver_cut 1-2)
DRIVER_PV="418.67"

DESCRIPTION="NVIDIA CUDA Toolkit (compiler and friends)"
HOMEPAGE="https://developer.nvidia.com/cuda-zone"
SRC_URI="https://developer.nvidia.com/compute/cuda/${MYD}/Prod/local_installers/cuda_${PV}_${DRIVER_PV}_linux.run -> cuda_${PV}_${DRIVER_PV}_linux.run"

LICENSE="NVIDIA-CUDA"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
IUSE="debugger doc eclipse profiler"

DEPEND=""
RDEPEND="${DEPEND}
	nvidia/nvidia-drivers
	debugger? (
		lib-sys/libtermcap-compat
		lib-sys/ncurses:5/5[tinfo]
		)
	eclipse? ( >=virtual/jre-1.6 )
	profiler? ( >=virtual/jre-1.6 )"

S="${WORKDIR}"

QA_PREBUILT="opt/cuda/*"

src_unpack() {
	unpacker
	unpacker run_files/cuda-linux*.run
}

src_prepare() {
	local cuda_supported_gcc

	cuda_supported_gcc="8.3"

	sed \
		-e "s:CUDA_SUPPORTED_GCC:${cuda_supported_gcc}:g" \
		"${FILESDIR}"/cuda-config.in > "${T}"/cuda-config || die

	default
}

src_install() {
	local i remove=( doc jre run_files install-linux.pl cuda-installer.pl extras/demo_suite/nbody extras/demo_suite/oceanFFT extras/demo_suite/randomFog )
	local cudadir=/opt/cuda
	local ecudadir="${EPREFIX}${cudadir}"

	use debugger || remove+=( bin/cuda-gdb extras/Debugger extras/cuda-gdb-${PV}.src.tar.gz )

	for i in "${remove[@]}"; do
		ebegin "Cleaning ${i}..."
		rm -rf "${i}" || die
		eend
	done

	dodir ${cudadir}
	mv * "${ED%/}${cudadir}" || die

	cat > "${T}"/99cuda <<- EOF || die
		PATH=${ecudadir}/bin$(usex profiler ":${ecudadir}/libnvvp" "")
		ROOTPATH=${ecudadir}/bin
		LDPATH=${ecudadir}/lib:${ecudadir}/lib:${ecudadir}/nvvm/lib
	EOF
	doenvd "${T}"/99cuda

	use profiler && \
		make_wrapper nvprof "${ecudadir}/bin/nvprof" "." "${ecudadir}/lib:${ecudadir}/lib"

	dobin "${T}"/cuda-config

	rm -rf "${ED}"/opt/cuda/NsightCompute-1.0
}
