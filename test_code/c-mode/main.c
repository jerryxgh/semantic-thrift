#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

/* Note: sdshdr5 is never used, we just access the flags byte directly.
 * However is here to document the layout of type 5 SDS strings. */
struct __attribute__ ((__packed__)) sdshdr5 {
    unsigned char flags; /* 3 lsb of type, and 5 msb of string length */
    char buf[];
};
struct __attribute__ ((__packed__)) sdshdr8 {
    uint8_t len; /* used */
    uint8_t alloc; /* excluding the header and null terminator */
    unsigned char flags; /* 3 lsb of type, 5 unused bits */
    char buf[];
};
struct __attribute__ ((__packed__)) sdshdr16 {
    uint16_t len; /* used */
    uint16_t alloc; /* excluding the header and null terminator */
    unsigned char flags; /* 3 lsb of type, 5 unused bits */
    char buf[];
};
struct __attribute__ ((__packed__)) sdshdr32 {
    uint32_t len; /* used */
    uint32_t alloc; /* excluding the header and null terminator */
    unsigned char flags; /* 3 lsb of type, 5 unused bits */
    char buf[];
};
struct __attribute__ ((__packed__)) sdshdr64 {
    uint64_t len; /* used */
    uint64_t alloc; /* excluding the header and null terminator */
    unsigned char flags; /* 3 lsb of type, 5 unused bits */
    char buf[];
};

struct __attribute__((aligned(64))) threads_pending {
    _Atomic unsigned long value;
};

struct __attribute__((aligned(64))) threads_pending1 {
    unsigned long value;
};

struct threads_pending2 {
    unsigned long value;
};

#define PRINT_LENGTH(T) printf("sizeof(%s): %zu\n", #T, sizeof(T))

int main() {
    // call a function in another file
    PRINT_LENGTH(struct sdshdr64);
    PRINT_LENGTH(struct sdshdr32);
    PRINT_LENGTH(struct sdshdr16);
    PRINT_LENGTH(struct sdshdr8);
    PRINT_LENGTH(struct sdshdr5);
    PRINT_LENGTH(struct threads_pending);
    PRINT_LENGTH(struct threads_pending1);
    PRINT_LENGTH(struct threads_pending2);

    printf("RAND_MAX: %d\n", RAND_MAX);

    return(0);
}
