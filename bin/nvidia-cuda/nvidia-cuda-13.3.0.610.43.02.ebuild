# Distributed under the terms of the GNU General Public License v2

inherit unpacker

MYD=$(ver_cut 1-2)
DRIVER_PV="$(ver_cut 4-6)"
PV="$(ver_cut 1-3)"

DESCRIPTION="NVIDIA CUDA Toolkit (compiler and friends)"
HOMEPAGE="https://developer.nvidia.com/cuda-zone"
SRC_URI="https://developer.download.nvidia.com/compute/cuda/${PV}/local_installers/cuda_${PV}_${DRIVER_PV}_linux.run"

LICENSE="NVIDIA-CUDA"
SLOT="0"
KEYWORDS="amd64"
S="${WORKDIR}"

IUSE="debugger rdma sanitizer"

RESTRICT="mirror strip"

DEPEND="bin/nvidia-drivers"
RDEPEND="
	${DEPEND}
	rdma? ( lib-net/rdma-core )
"
BDEPEND=""

QA_PREBUILT="opt/cuda/*"

src_install() {
	local cudadir=/opt/cuda
	local ecudadir="${EPREFIX}${cudadir}"
	local target=x86_64-linux
	local targetdir="${cudadir}/targets/${target}"
	local d

	local builddirs=(
		builds/{cccl,cuda_crt,cuda_ctadvisor,cuda_cudart,cuda_culibos,cuda_cuobjdump,cuda_cupti,cuda_cuxxfilt,cuda_nvcc,cuda_nvdisasm,cuda_nvml_dev,cuda_nvprune,cuda_nvrtc,cuda_nvtx,cuda_opencl,cuda_profiler_api,cuda_sandbox_dev,cuda_tileiras,libcublas,libcufft,libcurand,libcusolver,libcusparse,libnvfatbin,libnvjitlink,libnvjpeg,libnvptxcompiler,libnvvm}
		builds/libcufile
		$(usex rdma "builds/libcuobjclient" "")
		$(usex debugger "builds/cuda_gdb" "")
	)

	dodir "${cudadir}"
	mkdir -p "${ED}${cudadir}" || die "mkdir ${ED}${cudadir} failed"

	for d in "${builddirs[@]}"; do
		[[ -n ${d} ]] || continue
		[[ -d ${d} ]] || die "Directory does not exist: ${d}"

		if [[ ${d} == builds/libcufile ]]; then
			cp -an "${d}/targets" "${ED}${cudadir}/" || die "Failed to merge ${d}/targets into ${cudadir}"
			if ! use rdma; then
				rm -f \
					"${ED}${cudadir}/targets/${target}/lib/libcufile_rdma.so" \
					"${ED}${cudadir}/targets/${target}/lib/libcufile_rdma.so."* \
					"${ED}${cudadir}/targets/${target}/lib/libcufile_rdma_static.a" \
					|| die "Failed to drop RDMA-only libcufile objects"
			fi
			mkdir -p "${ED}${cudadir}/gds" || die "mkdir ${ED}${cudadir}/gds failed"
			cp -an "${d}/gds/cufile.json" "${d}/gds/EULA.txt" "${ED}${cudadir}/gds/" \
				|| die "Failed to install libcufile GDS metadata"
			cp -an "${d}/gds/doc" "${d}/gds/man" "${d}/gds/tools" "${ED}${cudadir}/gds/" \
				|| die "Failed to install libcufile GDS trees"
			cp -an "${d}/gds-${MYD}" "${ED}${cudadir}/" || die "Failed to install libcufile GDS versioned docs"
			continue
		fi

		if [[ ${d} == builds/libcuobjclient ]]; then
			cp -an "${d}/targets" "${ED}${cudadir}/" || die "Failed to merge ${d}/targets into ${cudadir}"
			mkdir -p "${ED}${cudadir}/gds" || die "mkdir ${ED}${cudadir}/gds failed"
			cp -an "${d}/gds/cuobject" "${ED}${cudadir}/gds/" \
				|| die "Failed to install libcuobjclient GDS docs"
			continue
		fi

		if [[ ${d} == builds/cuda_gdb ]]; then
			mkdir -p "${ED}${cudadir}/bin" || die "mkdir ${ED}${cudadir}/bin failed"
			mkdir -p "${ED}${cudadir}/extras" || die "mkdir ${ED}${cudadir}/extras failed"
			cp -an "${d}/bin/." "${ED}${cudadir}/bin/" || die "Failed to install cuda-gdb binaries"
			cp -an "${d}/extras/Debugger" "${ED}${cudadir}/extras/" || die "Failed to install cuda-gdb extras"
			cp -an "${d}/share" "${ED}${cudadir}/" || die "Failed to install cuda-gdb share data"
			continue
		fi

		cp -an "${d}/." "${ED}${cudadir}/" || die "Failed to merge ${d} into ${cudadir}"
	done

	insinto "${cudadir}"
	doins builds/EULA.txt builds/version.json

	if use sanitizer; then
		mkdir -p "${ED}${cudadir}/Sanitizer" || die "mkdir ${ED}${cudadir}/Sanitizer failed"
		cp -a "${S}"/builds/cuda_sanitizer_api/compute-sanitizer/. "${ED}${cudadir}/Sanitizer/" \
			|| die "Failed to install compute-sanitizer payload"
		into "${cudadir}"
		dobin "${S}"/builds/integration/Sanitizer/compute-sanitizer
	fi

	rm -f \
		"${ED}${targetdir}/lib/lib64" \
		"${ED}${targetdir}/include/include" \
		|| die "Failed to remove broken nested CUDA symlinks"

	[[ -e "${ED}${cudadir}/include" ]] || dosym -r "${targetdir}/include" "${cudadir}/include"
	[[ -e "${ED}${cudadir}/lib64" ]] || dosym -r "${targetdir}/lib" "${cudadir}/lib64"
	[[ -e "${ED}${cudadir}/lib" ]] || dosym -r "${targetdir}/lib" "${cudadir}/lib"
	if [[ -e "${ED}${cudadir}/pkg-config" && ! -e "${ED}${cudadir}/pkgconfig" ]]; then
		dosym -r "${cudadir}/pkg-config" "${cudadir}/pkgconfig"
	fi
	[[ -e "${ED}${targetdir}/lib64" ]] || dosym -r "${targetdir}/lib" "${targetdir}/lib64"

	newenvd - 99cuda <<-EOF
		CUDA_HOME=${ecudadir}
		CUDA_PATH=${ecudadir}
		CUDAToolkit_ROOT=${ecudadir}
		CUDACXX=${ecudadir}/bin/nvcc
		PATH=${ecudadir}/bin:${ecudadir}/nvvm/bin
		ROOTPATH=${ecudadir}/bin:${ecudadir}/nvvm/bin
		PKG_CONFIG_PATH=${ecudadir}/pkgconfig:${ecudadir}/pkg-config
		LDPATH=${ecudadir}/lib64:${ecudadir}/lib:${ecudadir}/targets/${target}/lib:${ecudadir}/nvvm/lib64
	EOF

	insinto /etc/profile.d
	newins - cuda.sh <<-EOF
		export CUDA_HOME=${ecudadir}
		export CUDA_PATH=${ecudadir}
		export CUDAToolkit_ROOT=${ecudadir}
		export CUDACXX=${ecudadir}/bin/nvcc
		export PKG_CONFIG_PATH=${ecudadir}/pkgconfig:${ecudadir}/pkg-config:\${PKG_CONFIG_PATH}
		export PATH=${ecudadir}/bin:${ecudadir}/nvvm/bin:\${PATH}
	EOF

	insinto /etc/revdep-rebuild
	newins - 80nvidia-cuda <<-EOF
		SEARCH_DIRS_MASK="${ecudadir}"
	EOF

	fowners -R root:root "${cudadir}"
}
