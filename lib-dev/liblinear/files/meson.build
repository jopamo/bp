project('liblinear', 'c', 'cpp',
  version: '5.0',
  default_options: ['buildtype=release', 'c_std=c11', 'cpp_std=c++11', 'b_lto=true']
)

cc = meson.get_compiler('c')
cxx = meson.get_compiler('cpp')


blas_sources = [
  'blas/dnrm2.c',
  'blas/daxpy.c',
  'blas/ddot.c',
  'blas/dscal.c'
]

blas_lib = static_library(
  'blas',
  blas_sources,
  install: false
)

liblinear_sources = [
  'linear.cpp',
  'newton.cpp'
]

liblinear_lib = shared_library(
  'linear',
  liblinear_sources,
  version: '5',
  soversion: '5',
  link_with: blas_lib,
  install: true,
  install_dir: '/usr/lib'
)

train_exe = executable(
  'train',
  ['train.c', 'newton.cpp', 'linear.cpp'],
  link_with: [liblinear_lib, blas_lib],
  install: true
)

predict_exe = executable(
  'predict',
  ['predict.c', 'newton.cpp', 'linear.cpp'],
  link_with: [liblinear_lib, blas_lib],
  install: true
)

summary({
  'C Compiler': cc.get_id(),
  'C++ Compiler': cxx.get_id(),
  'BLAS Library': blas_lib.full_path(),
  'Liblinear Shared Library': liblinear_lib.full_path(),
  'Train Executable': train_exe.full_path(),
  'Predict Executable': predict_exe.full_path(),
})
