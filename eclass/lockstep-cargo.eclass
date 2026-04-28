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

		LC_ALL=C
		for (( i=0; i<${#value}; ++i )); do
			char=${value:i:1}
			printf -v ord '%03d' "'${char}"
			encoded+="${ord}"
		done

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

			[[ -d ${source_dir} ]] || die "missing installed cargo crate package contents: ${source_dir}"
			mkdir -p "${dest_dir}" || die
			cp -pR "${source_dir}/." "${dest_dir}/" || die "failed staging ${ref}"
		done <<< "${CARGO_DEPS-}"
	}

	_LOCKSTEP_CARGO_DEPEND=$(_lockstep_cargo_dependency_atoms)
	DEPEND+="${_LOCKSTEP_CARGO_DEPEND}"

	inherit cargo

	lockstep-cargo_src_unpack() {
		[[ -d ${S} ]] || default
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
