# Distributed under the terms of the GNU General Public License v2
#
# @ECLASS: unpacker.eclass
# @SUPPORTED_EAPIS: 6 7 8
# @BLURB: helpers for extraneous file formats (Linux-centric) and
#         consistent behaviour across EAPIs.
#
# This eclass offers a unified interface for unpacking “odd” archive
# ­formats that are not directly handled by PMS or only in specific
# EAPIs.  It hides the nitty-gritty so ebuilds can simply call
#   unpacker
# in src_unpack() and forget the rest.

case ${EAPI} in
	6|7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_UNPACKER_ECLASS} ]]; then
_UNPACKER_ECLASS=1

inherit multiprocessing toolchain-funcs

# ── User-tweakable variables ──────────────────────────────────────────
#   (ebuilds SHOULD NOT set these; they are for the admin’s make.conf)

# @ECLASS_VARIABLE: UNPACKER_BZ2
# @USER_VARIABLE
# Utility used to decompress bzip2 files.  Auto-detects lbzip2/pbzip2/bzip2.
# Must understand ‘-dc’.  Example override in make.conf:
#   UNPACKER_BZ2="lbzip2 --threads=8 -dc"

# @ECLASS_VARIABLE: UNPACKER_LZIP
# @USER_VARIABLE
# Utility used to decompress lzip files.  Auto-detects xz/plzip/pdlzip/lzip.

# ── Internal helpers ─────────────────────────────────────────────────

# find_unpackable_file <name>
# Resolve <name> to an existing file, searching the usual places:
#   1. $DISTDIR
#   2. $PWD
#   3. literal path if already absolute/relative
# Returns the resolved path on stdout or exits 1 if not found.
find_unpackable_file() {
	local f=$1

	case ${f} in
		""      ) f=${DISTDIR}/${A} ;;
		./*     ) ;;                               # relative path as-is
		/*      ) ;;                               # absolute path as-is
		*       )
			if [[ -e ${DISTDIR}/${f} ]]; then
				f=${DISTDIR}/${f}
			elif [[ -e ${PWD}/${f} ]]; then
				f=${PWD}/${f}
			fi
			;;
	esac

	[[ -e ${f} ]] || die "unpacker.eclass: cannot locate '${1}'"
	printf '%s\n' "${f}"
}

# Simple, consistent banner shown before each extraction step
unpack_banner() {
	local fname=${1##*/}
	echo ">>> Unpacking ${fname} to ${PWD}"
}

# ---------------------------------------------------------------------------
# unpack_pdv <file> <sizeof(off_t)>
#   Extract a PDV self-extracting archive produced by Valve’s packer.
#   <sizeof(off_t)> must match the builder’s architecture (usually 4 or 8).
# ---------------------------------------------------------------------------
unpack_pdv() {
    local src sizeoff_t
    src=$(find_unpackable_file "$1") || die "cannot locate '$1'"
    sizeoff_t=$2
    [[ -n ${sizeoff_t} ]] || die "missing <size of off_t> parameter"

    unpack_banner "${src}"

    # ── read offsets ───────────────────────────────────────────────
    local metaskip tailskip
    metaskip=$(tail -c "${sizeoff_t}" -- "${src}" | hexdump -e '1/4 "%u"')
    tailskip=$(tail -c "$(( sizeoff_t * 2 ))" -- "${src}" |
               head -c  "${sizeoff_t}"          |
               hexdump -e '1/4 "%u"')

    # ── capture metadata (for debugging only) ──────────────────────
    local metafile="${T}/${FUNCNAME}.meta"
    tail -c "+$(( metaskip + 1 ))" -- "${src}" > "${metafile}"

    # ── discover payload name from metadata ────────────────────────
    local datafile
    datafile=$(strings "${metafile}" | head -n1)
    datafile=$(basename "${datafile:-pdv.payload}")

    # ── peek at first 512 B of payload to decide actions ───────────
    local tmp="${T}/${FUNCNAME}.$$"
    tail -c "+$(( tailskip + 1 ))" -- "${src}" | head -c 512 > "${tmp}"

    local fileinfo is_compressed is_tar
    fileinfo=$(file -S -b "${tmp}")
    [[ ${fileinfo} == compress* ]] && is_compressed=1 || is_compressed=0
    [[ ${fileinfo} == "POSIX tar"* ]] && is_tar=1 || is_tar=0
    rm -f "${tmp}"

    # ── extract ------------------------------------------------------------------
    # helper: stream payload (meta-start .. meta-end) to stdout
    _pdv_payload() {
        tail -c "+$(( tailskip + 1 ))" -- "${src}" 2>/dev/null |
        head -c "$(( metaskip - tailskip ))"
    }

    if (( is_compressed )); then
        if (( is_tar )); then
            _pdv_payload | tar -xzf -               || die "tar-z extraction failed"
        else
            _pdv_payload | gzip -dc > "${datafile}" || die "gzip extraction failed"
        fi
    else
        if (( is_tar )); then
            _pdv_payload | tar --no-same-owner -xf - || die "tar extraction failed"
        else
            _pdv_payload > "${datafile}"             || die "payload write failed"
        fi
    fi
}

# @FUNCTION: unpack_makeself
# @USAGE: [<archive>] [<offset>] [tail|dd]
# @DESCRIPTION:
# Extract a Makeself self-extracting archive.  Makeself wraps a shell script
# around a compressed tarball; the wrapper launches `tail` or `dd` to seek to
# the embedded payload and then unpacks it with the correct decompressor.
#
# * <archive>  –  the file to unpack (defaults to ${A})
# * <offset>   –  byte offset where the payload starts; if omitted the function
#                 auto-detects it for all known Makeself versions (1.5 → 2.4.5)
# * tail|dd    –  override the extractor (`tail -n +<offset>` or
#                 `dd ibs=<offset> skip=1`)  — rarely needed
#
# The archive is unpacked into ${PWD}.  Unknown Makeself versions trigger a
# clear error asking for a bug report.
unpack_makeself() {
    local src_input=${1:-${A}} src skip=$2 exe=$3 ver
    src=$(find_unpackable_file "${src_input}") \
        || die "cannot locate '${src_input}'"

    unpack_banner "${src}"

    if [[ -z ${skip} ]]; then
        ver=$(grep -am1 '#.*Makeself' "${src}" | awk '{print $NF}')
        exe=tail
        case ${ver} in
            1.5.*|1.6.0-nv*)  skip=$(grep -a ^skip= "${src}" | cut -d= -f2) ;;
            2.0|2.0.1)        skip=$(grep -a $'\t'tail "${src}" | awk '{print $2}' | cut -c2-) ;;
            2.1.1)            skip=$(grep -a ^offset= "${src}" | awk '{print $2}' | cut -c2-); ((skip++)) ;;
            2.1.2)            skip=$(grep -am1 ^offset= "${src}" | awk '{print $3}');           ((skip++)) ;;
            2.1.3)            skip=$(grep -a   ^offset= "${src}" | awk '{print $3}');           ((skip++)) ;;
            2.1.[456]|2.2.0|2.3.0|2.4.0)
                              skip=$(grep -a 'offset=.*head.*wc' "${src}" | awk '{print $3}' | head -n1)
                              skip=$(head -n "${skip}" "${src}" | wc -c)
                              exe=dd ;;
            2.4.5)
                              skip=$(sed -n '/^skip=/{s:skip="\(.*\)":\1:p;q}' "${src}")
                              skip=$(head -n "${skip}" "${src}" | wc -c)
                              exe=dd ;;
            *) die "unpack_makeself: unsupported version '${ver}' in ${src##*/}" ;;
        esac
    fi

    case ${exe} in
        tail) exe=( tail -n "+${skip}" -- "${src}" ) ;;
        dd)   exe=( dd ibs="${skip}" skip=1 if="${src}" ) ;;
        *)    die "unpack_makeself: invalid extractor '${exe}'" ;;
    esac

    local probe tmp="${T}/${FUNCNAME}.$$" decomp filetype suffix
    "${exe[@]}" 2>/dev/null | head -c 512 > "${tmp}"
    filetype=$(file -S -b "${tmp}") || die
    rm -f "${tmp}"

    case ${filetype} in
        *tar\ archive*) decomp=cat ;;
        bzip2*)         suffix=bz2 ;;
        gzip*)          suffix=gz  ;;
        compress*)      suffix=z   ;;
        XZ*)            suffix=xz  ;;
        Zstandard*)     suffix=zst ;;
        lzop*)          suffix=lzo ;;
        LZ4*)           suffix=lz4 ;;
        "ASCII text"*)  decomp='base64 -d' ;;
        *) die "unpack_makeself: unknown payload type '${filetype}' in ${src##*/}" ;;
    esac

    [[ -z ${decomp} ]] && decomp=$(_unpacker_get_decompressor ".${suffix}")
    "${exe[@]}" | ${decomp} | tar --no-same-owner -xf - \
        || die "unpack_makeself: extraction failed for ${src##*/}"
}

# ────────────────────────────────
# Debian .deb
# ────────────────────────────────
unpack_deb() {
    [[ $# -eq 1 ]] || die "usage: ${FUNCNAME} <deb-file>"
    local deb
    deb=$(find_unpackable_file "$1") || die "cannot locate '$1'"
    unpack_banner "${deb}"

    local ar=$(tc-getAR) data decomp
    data=$("${ar}" t "${deb}" | grep -m1 -E '^data\.tar') \
        || die "no data.tar* member in ${deb}"
    decomp=$(_unpacker_get_decompressor "${data}")
    "${ar}" p "${deb}" "${data}" | ${decomp:-cat} | tar --no-same-owner -xf - \
        || die "unpacking ${deb} failed"
}

# ────────────────────────────────
# cpio (file “-” == stdin)
# ────────────────────────────────
unpack_cpio() {
    [[ $# -eq 1 ]] || die "usage: ${FUNCNAME} <cpio-file | ->"

    local cmd=( cpio --make-directories --extract --preserve-modification-time )
    if [[ $1 == "-" ]]; then
        unpack_banner "stdin"
        "${cmd[@]}"
    else
        local cpio
        cpio=$(find_unpackable_file "$1") || die
        unpack_banner "${cpio}"
        "${cmd[@]}" < "${cpio}"
    fi
}

# ────────────────────────────────
# ZIP
# ────────────────────────────────
unpack_zip() {
    [[ $# -eq 1 ]] || die "usage: ${FUNCNAME} <zip-file>"
    local zip
    zip=$(find_unpackable_file "$1") || die
    unpack_banner "${zip}"

    # unzip returns 1 for non-fatal “junk after EOF” — treat >1 as fatal
    unzip -qo "${zip}" || [[ $? -le 1 ]] \
        || die "unpacking ${zip} failed (unzip exit $?)"
}

# ────────────────────────────────
# 7-Zip
# ────────────────────────────────
unpack_7z() {
    [[ $# -eq 1 ]] || die "usage: ${FUNCNAME} <7z-file>"
    local p7z
    p7z=$(find_unpackable_file "$1") || die
    unpack_banner "${p7z}"

    local out
    if ! out=$(7z x -y "${p7z}" 2>&1); then
        echo "${out}" >&2
        die "unpacking ${p7z} failed (7z)"
    fi
}

# ────────────────────────────────
# RAR
# ────────────────────────────────
unpack_rar() {
    [[ $# -eq 1 ]] || die "usage: ${FUNCNAME} <rar-file>"
    local rar
    rar=$(find_unpackable_file "$1") || die
    unpack_banner "${rar}"
    unrar x -idq -o+ "${rar}" \
        || die "unpacking ${rar} failed (unrar)"
}

# ────────────────────────────────
# LHA / LZH
# ────────────────────────────────
unpack_lha() {
    [[ $# -eq 1 ]] || die "usage: ${FUNCNAME} <lha-file>"
    local lha
    lha=$(find_unpackable_file "$1") || die
    unpack_banner "${lha}"
    lha xfq "${lha}" \
        || die "unpacking ${lha} failed (lha)"
}

# ────────────────────────────────
# Detect decompressor from file-name
# ────────────────────────────────
_unpacker_get_decompressor() {
    case $1 in
        *.bz2|*.tbz|*.tbz2)
            local bz=${PORTAGE_BUNZIP2_COMMAND:-${PORTAGE_BZIP2_COMMAND:-}}
            if [[ -z ${bz} ]]; then
                bz=$(type -P lbzip2 || type -P pbzip2 || echo bzip2)
            fi
            echo "${bz} -dc"
            ;;

        *.gz|*.tgz|*.z)  echo "gzip -dc" ;;
        *.xz|*.txz|*.lzma)
            echo "xz -T$(makeopts_jobs) -dc" ;;
        *.lz)
            if [[ -z ${UNPACKER_LZIP} ]]; then
                if has_version -b ">=app-compression/xz-utils-5.4.0"; then
                    UNPACKER_LZIP=xz           # new xz handles .lz
                else
                    for lz in plzip pdlzip lzip; do
                        type -P "${lz}" >/dev/null && { UNPACKER_LZIP=${lz}; break; }
                    done
                fi
            fi
            echo "${UNPACKER_LZIP:-lzma} -dc"
            ;;
        *.zst) echo "zstd -dc" ;;
        *.lz4) echo "lz4 -dc"  ;;
        *.lzo) echo "lzop -dc" ;;
        *)     echo ""         ;;  # no decompressor needed
    esac
}

# ────────────────────────────────
# .gpkg (Gentoo binary package) – image sub-archive only
# ────────────────────────────────
unpack_gpkg() {
    [[ $# -eq 1 ]] || die "usage: ${FUNCNAME} <gpkg>"
    local gpkg; gpkg=$(find_unpackable_file "$1") || die
    unpack_banner "${gpkg}"

    # locate the single image.tar* member
    local images=()
    while read -r l; do
        [[ ${l} == */image.tar* ]] && [[ ${l} != *.sig ]] && images+=( "${l}" )
    done < <(tar -tf "${gpkg}" || die "unable to list ${gpkg}")

    [[ ${#images[@]} -eq 1 ]] \
        || die "expected exactly one image.tar in ${gpkg}, found ${#images[@]}"

    local decomp; decomp=$(_unpacker_get_decompressor "${images[0]}")
    local dstdir=${images[0]%/*}
    mkdir -p "${dstdir}" || die
    tar -xOf "${gpkg}" "${images[0]}" | ${decomp:-cat} \
        | tar --no-same-owner -C "${dstdir}" -xf - \
        || die "unpacking ${gpkg} failed"
}

# ────────────────────────────────
# Core dispatcher (one archive)
# ────────────────────────────────
_unpacker() {
    [[ $# -eq 1 ]] || die "usage: ${FUNCNAME} <archive>"

    local a m comp arch=""
    a=$(find_unpackable_file "$1") || die
    m=${a,,}                            # lowercase for pattern matching

    comp=$(_unpacker_get_decompressor "${m}")

    case ${m} in
        *.gpkg.tar)                      arch=unpack_gpkg ;;
        *.tar.*|*.tgz|*.tbz|*.tbz2|*.txz|*.tar)
            arch='tar --no-same-owner -xof' ;;
        *.cpio.*|*.cpio)                 arch=unpack_cpio    ;;
        *.deb)                           arch=unpack_deb     ;;
        *.run)                           arch=unpack_makeself;;
        *.sh|*.bin)
            head -n 30 "${a}" | grep -qs '#.*Makeself' && arch=unpack_makeself ;;
        *.zip)                           arch=unpack_zip     ;;
    esac

    # 7z/rar/lha only in EAPI ≥ 8
    if [[ ${EAPI} != [67] ]]; then
        case ${m} in
            *.7z)          arch=unpack_7z  ;;
            *.rar)         arch=unpack_rar ;;
            *.lha|*.lzh)   arch=unpack_lha ;;
        esac
    fi

    # Fallback to PMS `unpack` if nothing special matched
    if [[ -z ${arch}${comp} ]]; then
        unpack "${a}"
        return
    fi

    [[ ${arch} != unpack_* ]] && unpack_banner "${a}"

    if [[ -z ${arch} ]]; then
        # only a decompressor – write raw output
        local out=${a%.*}
        ${comp} < "${a}" > "${out##*/}" || die "decompression failed for ${a}"
    elif [[ -z ${comp} ]]; then
        ${arch} "${a}"
    else
        ${comp} < "${a}" | ${arch} - || die "unpack pipeline failed"
    fi
}

# ────────────────────────────────
# Public helpers
# ────────────────────────────────
unpacker() {
    [[ $# -eq 0 ]] && set -- ${A}
    local f; for f; do _unpacker "${f}"; done
}

unpacker_src_unpack() { unpacker; }

# Collect build-time deps implied by SRC_URI
unpacker_src_uri_depends() {
    local -A deps
    local uri
    [[ $# -eq 0 ]] && set -- ${SRC_URI//\n/ }

    for uri in "$@"; do
        case ${uri,,} in
            *.cpio.*|*.cpio)      deps[cpio]="app-compression/cpio" ;;
            *.rar)               deps[rar]="app-compression/unrar" ;;
            *.7z)                deps[7z]="app-compression/7zip" ;;
            *.xz)                deps[xz]="app-compression/xz-utils" ;;
            *.zip)               deps[zip]="app-compression/unzip" ;;
            *.lz)
                deps[lz]="|| (
                    >=app-compression/xz-utils-5.4.0
                    app-compression/plzip
                    app-compression/pdlzip
                    app-compression/lzip
                )" ;;
            *.zst)               deps[zst]="app-compression/zstd" ;;
            *.lha|*.lzh)         deps[lha]="app-compression/lha" ;;
            *.lz4)               deps[lz4]="app-compression/lz4" ;;
            *.lzo)               deps[lzo]="app-compression/lzop" ;;
        esac
    done

    # echo the values, preserving order only loosely
    echo "${deps[*]}"
}

fi

EXPORT_FUNCTIONS src_unpack
