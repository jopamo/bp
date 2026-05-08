# Distributed under the terms of the GNU General Public License v2
#
# @ECLASS: lockstep-cargo.eclass
# @BLURB: Consume lockstep-managed rust-crates packages as Cargo vendor input
#

if [[ -z ${_LOCKSTEP_LOCKSTEP_CARGO_ECLASS} ]]; then
	_LOCKSTEP_LOCKSTEP_CARGO_ECLASS=1

	LOCKSTEP_CARGO_PACKAGE_ROOT="/usr/share/lockstep/cargo-crates"

	_lockstep_cargo_trim_ws() {
		local value=${1}

		value=${value#"${value%%[![:space:]]*}"}
		value=${value%"${value##*[![:space:]]}"}

		printf '%s\n' "${value}"
	}

	_lockstep_cargo_ref_split() {
		local ref=${1#rust-crates/}
		local i crate version

		for (( i=0; i<${#ref}; ++i )); do
			[[ ${ref:i:1} == "-" ]] || continue
			crate=${ref:0:i}
			version=${ref:i+1}
			if [[ -n ${crate} && ${version} =~ ^[0-9]+\.[0-9]+\.[0-9]+(\.[0-9]+)*(-[0-9A-Za-z.-]+)?(\+[0-9A-Za-z.-]+)?$ ]]; then
				printf '%s\t%s\n' "${crate}" "${version}"
				return
			fi
		done

		die "invalid lockstep cargo ref without parseable crate/version split: ${1}"
	}

	_lockstep_cargo_ref_version() {
		local split
		split=$(_lockstep_cargo_ref_split "${1}")
		printf '%s\n' "${split#*$'\t'}"
	}

	_lockstep_cargo_ref_crate() {
		local split
		split=$(_lockstep_cargo_ref_split "${1}")
		printf '%s\n' "${split%%$'\t'*}"
	}

	_lockstep_cargo_portage_package_name() {
		local crate=${1}
		local normalized=${crate//[^A-Za-z0-9+_-]/_}
		local prefix suffix

		[[ -n ${normalized} ]] || normalized=_
		case ${normalized:0:1} in
			+|-)
				normalized="_${normalized:1}"
				;;
		esac

		while [[ ${normalized} =~ -[0-9]+(\.[0-9]+)*[a-z]?(_(pre|p|beta|alpha|rc)[0-9]*)*(-r[0-9]+)?$ ]]; do
			prefix=${normalized%-*}
			suffix=${normalized##*-}
			normalized="${prefix}_${suffix}"
		done

		printf '%s\n' "${normalized}"
	}

	_lockstep_cargo_encode_segment() {
		local value=${1}
		local encoded= i char ord
		local hash_hi=5381
		local hash_lo=52711

		LC_ALL=C
		for (( i=0; i<${#value}; ++i )); do
			char=${value:i:1}
			printf -v ord '%03d' "'${char}"
			encoded+="${ord}"
		done

		# Portage and gpkg can choke on absurdly long PVs when Cargo build
		# metadata carries a full git describe string. Keep the legacy,
		# reversible ASCII-decimal encoding for normal cases, but collapse
		# pathological tails to a deterministic numeric digest computed with
		# shell arithmetic, since global ebuild scope forbids external tools.
		if [[ ${#encoded} -gt 96 ]] ; then
			for (( i=0; i<${#value}; ++i )); do
				char=${value:i:1}
				printf -v ord '%d' "'${char}"
				hash_hi=$(( ((hash_hi << 5) + hash_hi + ord) & 0x7fffffffffffffff ))
				hash_lo=$(( (((hash_lo << 5) + hash_lo) ^ ord) & 0x7fffffffffffffff ))
			done
			printf '999%03d%019d%019d\n' "${#value}" "${hash_hi}" "${hash_lo}"
			return
		fi

		printf '%s\n' "${encoded}"
	}

	_lockstep_cargo_render_prerelease() {
		local prerelease=${1}

		if [[ ${prerelease} =~ ^(alpha|beta|pre|rc)[.-]?([0-9]+)?$ ]]; then
			printf '_%s%s\n' "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]:-0}"
			return
		fi

		printf '_pre%s\n' "$(_lockstep_cargo_encode_segment "${prerelease}")"
	}

	_lockstep_cargo_portage_version() {
		local version=${1}
		local core prerelease build tail

		if [[ ${version} =~ ^([0-9]+(\.[0-9]+)*)(-([0-9A-Za-z.-]+))?(\+([0-9A-Za-z.-]+))?$ ]]; then
			core=${BASH_REMATCH[1]}
			prerelease=${BASH_REMATCH[4]}
			build=${BASH_REMATCH[6]}
			printf '%s' "${core}"
			[[ -n ${prerelease} ]] && printf '%s' "$(_lockstep_cargo_render_prerelease "${prerelease}")"
			[[ -n ${build} ]] && printf '_p%s' "$(_lockstep_cargo_encode_segment "${build}")"
			printf '\n'
			return
		fi

		if [[ ${version} =~ ^([0-9]+(\.[0-9]+)*)(.*)$ ]]; then
			core=${BASH_REMATCH[1]}
			tail=${BASH_REMATCH[3]}
			printf '%s' "${core}"
			[[ -n ${tail} ]] && printf '_p%s' "$(_lockstep_cargo_encode_segment "${tail}")"
			printf '\n'
			return
		fi

		die "unsupported cargo crate version for Portage atom rendering: ${version}"
	}

	_lockstep_cargo_dependency_atoms() {
		local ref atoms= crate package version

		while IFS= read -r ref; do
			ref=$(_lockstep_cargo_trim_ws "${ref}")
			[[ -n ${ref} ]] || continue
			crate=$(_lockstep_cargo_ref_crate "${ref}")
			package=$(_lockstep_cargo_portage_package_name "${crate}")
			version=$(_lockstep_cargo_ref_version "${ref}")
			atoms+=$'\n\t='"rust-crates/${package}-$(_lockstep_cargo_portage_version "${version}")"
		done <<< "${CARGO_DEPS-}"

		printf '%s\n' "${atoms}"
	}

	_lockstep_cargo_copy_tree() {
		local source_dir=${1}
		local dest_dir=${2}

		mkdir -p "${dest_dir}" || die
		tar -C "${source_dir}" -cf - . | tar -C "${dest_dir}" -xf - \
			|| die "failed copying cargo crate payload from ${source_dir}"
	}

	_lockstep_cargo_package_checksum() {
		local source_dir=${1}
		local checksum_file="${source_dir}/.cargo-checksum.json"
		local json package_checksum

		[[ -f ${checksum_file} ]] || die "missing cargo checksum metadata: ${checksum_file}"
		json=$(tr -d '\n\r\t ' < "${checksum_file}") || die "failed reading ${checksum_file}"
		package_checksum=${json#*\"package\":\"}
		package_checksum=${package_checksum%%\"*}
		[[ -n ${package_checksum} ]] || die "failed parsing package checksum from ${checksum_file}"
		printf '%s\n' "${package_checksum}"
	}

	_lockstep_cargo_extract_distfile() {
		local crate=${1}
		local version=${2}
		local distfile="${DISTDIR}/${crate}-${version}.crate"
		local extracted_dir="${ECARGO_VENDOR}/${crate}-${version}"
		local package_checksum

		[[ -f ${distfile} ]] || return 1
		tar -C "${ECARGO_VENDOR}" -xzf "${distfile}" \
			|| die "failed extracting cargo crate distfile ${distfile}"
		[[ -d ${extracted_dir} ]] \
			|| die "cargo crate distfile ${distfile} did not unpack to ${extracted_dir}"
		package_checksum=$(sha256sum "${distfile}" | awk '{print $1}') || die
		_cargo_write_checksum_file "${extracted_dir}" "${package_checksum}"
		return 0
	}

	_lockstep_cargo_populate_vendor() {
		local ref crate version sysroot source_dir dest_dir

		rm -rf "${ECARGO_VENDOR}"
		mkdir -p "${ECARGO_VENDOR}" || die

		while IFS= read -r ref; do
			ref=$(_lockstep_cargo_trim_ws "${ref}")
			[[ -n ${ref} ]] || continue

			crate=$(_lockstep_cargo_ref_crate "${ref}")
			version=$(_lockstep_cargo_ref_version "${ref}")
			sysroot=${ESYSROOT%/}
			source_dir="${sysroot}${LOCKSTEP_CARGO_PACKAGE_ROOT}/${crate}/${version}"
			dest_dir="${ECARGO_VENDOR}/${crate}-${version}"

			if ! _lockstep_cargo_extract_distfile "${crate}" "${version}"; then
				[[ -d ${source_dir} ]] || die "missing installed cargo crate package contents: ${source_dir}"
				_lockstep_cargo_copy_tree "${source_dir}" "${dest_dir}" || die "failed staging ${ref}"
				_cargo_write_checksum_file "${dest_dir}" "$(_lockstep_cargo_package_checksum "${source_dir}")"
			fi
			chmod -R u+rwX,go+rX "${dest_dir}" || die "failed normalizing staged permissions for ${ref}"
		done <<< "${CARGO_DEPS-}"
	}

	_LOCKSTEP_CARGO_DEPEND=$(_lockstep_cargo_dependency_atoms)
	DEPEND+="${_LOCKSTEP_CARGO_DEPEND}"

	inherit cargo

	[[ -n ${CARGO_DEPS-} ]] && CARGO_CRATE_URIS=

	cargo_src_unpack() {
		[[ -d ${S} ]] || default
	}

	lockstep-cargo_src_unpack() {
		cargo_src_unpack
	}

	cargo_gen_config() {
		export CARGO_HOME="${ECARGO_HOME}"
		mkdir -p "${CARGO_HOME}" || die
		rm -f "${CARGO_HOME}/config.toml"

		[[ -n ${CARGO_DEPS-} ]] || die "lockstep-cargo.eclass requires CARGO_DEPS"
		_lockstep_cargo_populate_vendor

		cat > "${CARGO_HOME}/config.toml" <<-EOF_CONFIG || die "failed writing ${CARGO_HOME}/config.toml"
			[source.crates-io]
			replace-with = "bp-lockstep-vendor"

			[source.bp-lockstep-vendor]
			directory = "${ECARGO_VENDOR}"
		EOF_CONFIG
	}

	EXPORT_FUNCTIONS src_unpack
fi
