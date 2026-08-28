# Distributed under the terms of the GNU General Public License v2

case ${EAPI:-0} in
	8) ;;
	*) die "hackage.eclass requires EAPI 8" ;;
esac

HACKAGE_PROJECT_FILE=${T}/cabal.project.lockstep
HACKAGE_CONFIG_FILE=${T}/cabal.config.lockstep
HACKAGE_REPOSITORY_DIR=${T}/hackage-repository

hackage_set_globals() {
	local entry name version revision sha256

	for entry in "${HACKAGE_DEPS[@]}"; do
		read -r name version revision sha256 <<< "${entry}"
		[[ -n ${name} && -n ${version} && ${revision} == +([0-9]) &&
			${sha256} == +([0-9a-f]) && ${#sha256} -eq 64 ]] ||
			die "invalid HACKAGE_DEPS entry: ${entry}"
		if [[ ${name} != "${HACKAGE_PRIMARY_PACKAGE-}" ]]; then
			SRC_URI+=" https://hackage.haskell.org/package/${name}-${version}/${name}-${version}.tar.gz
				-> hackage-${name}-${version}.tar.gz"
		fi
		SRC_URI+=" https://hackage.haskell.org/package/${name}-${version}/revision/${revision}.cabal
			-> hackage-${name}-${version}.cabal"
	done
}

hackage_src_unpack() {
	local entry name version revision sha256 actual_sha256

	default

	for entry in "${HACKAGE_DEPS[@]}"; do
		read -r name version revision sha256 <<< "${entry}"
		actual_sha256=$(sha256sum \
			"${DISTDIR}/hackage-${name}-${version}.cabal") || die
		[[ ${actual_sha256%% *} == "${sha256}" ]] ||
			die "Hackage revision checksum mismatch for ${name}-${version}"
		local package_dir="${WORKDIR}/${name}-${version}"
		if [[ ${name} == "${HACKAGE_PRIMARY_PACKAGE-}" ]]; then
			package_dir=${S}
		fi
		cp \
			"${DISTDIR}/hackage-${name}-${version}.cabal" \
			"${package_dir}/${name}.cabal" || die
	done
}

hackage_write_project() {
	local entry name version revision sha256

	mkdir -p \
		"${T}/cabal-cache" \
		"${T}/cabal-logs" \
		"${T}/cabal-store" \
		"${HACKAGE_REPOSITORY_DIR}" || die

	for entry in "${HACKAGE_DEPS[@]}"; do
		read -r name version revision sha256 <<< "${entry}"
		[[ ${name} == "${HACKAGE_PRIMARY_PACKAGE-}" ]] && continue
		ln -sf \
			"${DISTDIR}/hackage-${name}-${version}.tar.gz" \
			"${HACKAGE_REPOSITORY_DIR}/${name}-${version}.tar.gz" || die
		ln -sf \
			"${DISTDIR}/hackage-${name}-${version}.cabal" \
			"${HACKAGE_REPOSITORY_DIR}/${name}-${version}.cabal" || die
	done

	{
		printf '%s\n' \
			"active-repositories: lockstep" \
			"remote-repo-cache: ${T}/cabal-cache" \
			"logs-dir: ${T}/cabal-logs" \
			"store-dir: ${T}/cabal-store" \
			"world-file: ${T}/cabal-world"
	} > "${HACKAGE_CONFIG_FILE}" || die

	{
		printf '%s\n' \
			"active-repositories: lockstep" \
			"packages:" \
			"  ${S}"
		printf '%s\n' \
			"tests: False" \
			"benchmarks: False" \
			"write-ghc-environment-files: never"
	} > "${HACKAGE_PROJECT_FILE}" || die
}

hackage_cabal_build() {
	local cabal=${HACKAGE_CABAL:-cabal}

	hackage_write_project
	"${cabal}" \
		--config-file="${HACKAGE_CONFIG_FILE}" \
		--local-no-index-repo="lockstep:${HACKAGE_REPOSITORY_DIR}" \
		update || die
	"${cabal}" \
		--config-file="${HACKAGE_CONFIG_FILE}" \
		--local-no-index-repo="lockstep:${HACKAGE_REPOSITORY_DIR}" \
		--project-file="${HACKAGE_PROJECT_FILE}" \
		v2-build \
		--disable-tests \
		--disable-benchmarks \
		"$@" || die
}

hackage_cabal_list_bin() {
	local cabal=${HACKAGE_CABAL:-cabal}

	"${cabal}" \
		--config-file="${HACKAGE_CONFIG_FILE}" \
		--local-no-index-repo="lockstep:${HACKAGE_REPOSITORY_DIR}" \
		--project-file="${HACKAGE_PROJECT_FILE}" \
		list-bin \
		"$@" || die
}

EXPORT_FUNCTIONS src_unpack
