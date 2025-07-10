# @ECLASS: font.eclass
# @SUPPORTED_EAPIS: 7 8

case ${EAPI} in
	7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_FONT_ECLASS} ]]; then
	_FONT_ECLASS=1

# If unset, use defaults.
FONT_SUFFIX=${FONT_SUFFIX:-}
FONT_PN=${FONT_PN:-${PN}}
FONTDIR=${FONTDIR:-/usr/share/fonts/${FONT_PN}}
FONT_CONF=( "" )

if [[ ${CATEGORY}/${PN} != fonts/encodings ]]; then
	IUSE="X"
	BDEPEND="X? (
		>=xgui-tools/mkfontscale-1.2.0
		fonts/encodings
	)"
fi

font_wrap_opentype_compat() {
	local file tmp
	while IFS= read -rd '' file; do
		if [[ $file == *.gz ]]; then
			tmp=${file%.gz}
			gzip -cd -- "$file" > "$tmp" && \
			fonttosfnt -v -o "${tmp%.*}.otb" -- "$tmp" && rm -- "$tmp"
		else
			fonttosfnt -v -o "${file%.*}.otb" -- "$file"
		fi || ! break
	done < <(find "${ED}" -type f \( -name '*.bdf'* -o -name '*.pcf'* \) -print0) || die
}

font_xfont_config() {
	local d="${1:-${FONT_PN}}"
	if in_iuse X && use X; then
		rm -f "${ED}${FONTDIR}/${1//${S}/}"/{fonts.{dir,scale},encodings.dir} || die
		einfo "mkfontscale + mkfontdir in ${d##*/}"
		mkfontscale "${ED}${FONTDIR}/${1//${S}/}" || eerror "mkfontscale failed"
		mkfontdir -e "${EPREFIX}"/usr/share/fonts/encodings -e "${EPREFIX}"/usr/share/fonts/encodings/large \
			"${ED}${FONTDIR}/${1//${S}/}" || eerror "mkfontdir failed"
		[[ -e fonts.alias ]] && doins fonts.alias
	fi
}

font_fontconfig() {
	[[ -n ${FONT_CONF[@]} ]] || return 0
	insinto /etc/fonts/conf.avail/
	local c
	for c in "${FONT_CONF[@]}"; do
		[[ -e $c ]] && doins "$c"
	done
}

font_cleanup_dirs() {
	local gen="encodings.dir fonts.alias fonts.cache-1 fonts.dir fonts.scale" d
	ebegin "Removing empty-generated font dirs"
	while IFS= read -rd '' d; do
		local candidate=false otherfile=false
		for f in "$d"/*; do
			[[ -e $f || -L $f ]] || continue
			if has ${f##*/} ${gen}; then
				candidate=true
			else
				otherfile=true
			fi
			[[ $candidate == $otherfile ]] && break
		done
		if [[ $candidate == true && $otherfile == false ]]; then
			for g in $gen; do
				[[ $g != fonts.alias && -e $d/$g ]] && rm "$d/$g"
			done
			find "$d" -maxdepth 0 -type d -empty -delete
		fi
	done < <(find -L "${EROOT}"/usr/share/fonts/ -type d -print0)
	eend 0
}

font_src_install() {
	local dir suffix

	if [[ $(declare -p FONT_S 2>/dev/null) == "declare -a"* ]]; then
		for dir in "${FONT_S[@]}"; do
			pushd "$dir" >/dev/null || die
			insinto "${FONTDIR}/${dir#"${S}"}"
			for suffix in ${FONT_SUFFIX}; do
				doins *."${suffix}"
			done
			font_xfont_config "$dir"
			popd >/dev/null || die
		done
	else
		pushd "${FONT_S:-${S}}" >/dev/null || die
		insinto "${FONTDIR}"
		for suffix in ${FONT_SUFFIX}; do
			doins *."${suffix}"
		done
		font_xfont_config
		popd >/dev/null || die
	fi

	font_fontconfig

	local docf
	for docf in COPYRIGHT FONTLOG.txt; do
		[[ -s $docf ]] && dodoc "$docf"
	done
}

_update_fontcache() {
	[[ -z $ROOT ]] || return 0
	if has_version fonts/fontconfig; then
		ebegin "Updating global fontcache"
		fc-cache -fs || die "fc-cache failed"
		eend 0
	else
		einfo "Skipping fontcache update (fonts/fontconfig not installed)"
	fi
}

font_pkg_postinst() {
	if [[ -n ${FONT_CONF[@]} ]]; then
		local cf
		elog "Installed fontconfig files:"
		for cf in "${FONT_CONF[@]}"; do
			[[ -e ${EROOT}/etc/fonts/conf.avail/${cf##*/} ]] && elog "  ${cf##*/}"
		done
		elog "Use 'eselect fontconfig' to enable/disable them."
	fi
	_update_fontcache
}

font_pkg_postrm() {
	font_cleanup_dirs
	_update_fontcache
}

fi

EXPORT_FUNCTIONS src_install pkg_postinst pkg_postrm
