#ifndef _SYS_CDEFS_H_
#define _SYS_CDEFS_H_

#warning usage of non-standard #include <sys/cdefs.h> is deprecated

#define __P(args)        args
#define __PMT(args)      args

#define __CONCAT(x, y)   x ## y
#define __STRING(x)      #x

#ifdef __cplusplus
# define __BEGIN_DECLS   extern "C" {
# define __END_DECLS     }
#else
# define __BEGIN_DECLS
# define __END_DECLS
#endif

#if defined(__GNUC__)
# define __THROW         __attribute__((__nothrow__))
# define __NTH(fct)      __attribute__((__nothrow__)) fct
# define __PURE          __attribute__((__pure__))
# define __CONST         __attribute__((__const__))
# define __DEPRECATED    __attribute__((__deprecated__))
# define __UNUSED        __attribute__((__unused__))
# define __INLINE        __attribute__((__always_inline__)) inline
#else
# define __THROW
# define __NTH(fct)      fct
# define __PURE
# define __CONST
# define __DEPRECATED
# define __UNUSED
# define __INLINE        inline
#endif

#endif /* _SYS_CDEFS_H_ */
