project('bzip2', 'c', version : '1.0.6')

bzip2_sources = [
  'blocksort.c',
  'huffman.c',
  'crctable.c',
  'randtable.c',
  'compress.c',
  'decompress.c',
  'bzlib.c'
]

libversion = meson.project_version()
soversion = '1'

bz2_incs = include_directories('.')

install_headers(['bzlib.h'])

libtype = 'both'

if libtype != 'shared'
  libbz2_shared = shared_library('bz2', bzip2_sources,
    version : libversion,
    soversion : soversion,
    include_directories : bz2_incs,
    install : true,
#    dependencies : mathlib,
#    vs_module_defs: vs_module_defs_dir + 'libbz2.def',
  )
  libbz2 = libbz2_shared
endif

if libtype != 'static'
  libbz2_static = static_library('bz2', bzip2_sources,
    include_directories : bz2_incs,
    install : true,
#    dependencies : mathlib,
  )
  libbz2 = libbz2_static
endif

bz2_dep = declare_dependency(link_with : libbz2, include_directories : bz2_incs)

