project('b3sum', 'c',
  version: '1.0',
  default_options: ['buildtype=release', 'c_std=c11', 'default_library=shared'])

cc = meson.get_compiler('c')

blake3_sources = [
  'blake3.c',
  'blake3_dispatch.c',
  'blake3_portable.c',
  'blake3_sse2_x86-64_unix.S',
  'blake3_sse41_x86-64_unix.S',
  'blake3_avx2_x86-64_unix.S',
  'blake3_avx512_x86-64_unix.S',
]

simd_args = []

blake3_lib = library('blake3', blake3_sources, c_args: simd_args, install: true)

math_lib = cc.find_library('m')

executable('b3sum',
  ['b3sum.c'],
  link_with: blake3_lib,
  dependencies: [math_lib],
  install: true,
  c_args: simd_args
)

summary({
  'SIMD Arguments': simd_args,
  'BLAKE3 Source Files': blake3_sources
})
