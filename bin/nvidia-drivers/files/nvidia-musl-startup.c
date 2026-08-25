#include <stdint.h>

/*
 * This DSO has no runtime policy. Its stable SONAME gives a musl-native
 * process one durable DT_NEEDED edge while its build-time DT_NEEDED records
 * the exact NVIDIA TLS DSO shipped by this driver release.
 */
__attribute__((visibility("default"))) const uint32_t nvidia_musl_startup_abi =
    1;
