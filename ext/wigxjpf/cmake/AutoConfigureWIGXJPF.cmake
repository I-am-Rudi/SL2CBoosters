include(CheckCSourceCompiles)
include(CMakePushCheckState)

cmake_push_check_state() # Save variables
set(CMAKE_REQUIRED_FLAGS -Werror)
set(CMAKE_REQUIRED_LIBRARIES m)
check_c_source_compiles("
    #include <math.h>
    int main() {
        long double a;
        long double b = 1.14, c = 2.00159;
        long double d;

        a = b + c;
        d = ldexpl(c, 5);
        return 0;
    }
    "
    HAS_LONG_DOUBLE
)
set(CMAKE_REQUIRED_LIBRARIES quadmath)
check_c_source_compiles("
    #include \"quadmath.h\"
    int main() {
        __float128 a;
        __float128 b = 1.14, c = 2.00159;
        char s[64];

        a = b + c;

        quadmath_snprintf(s, sizeof(s), \"%Qf\", a);
        return 0;
    }
    "
    HAS_FLOAT128
)
set(CMAKE_REQUIRED_LIBRARIES "")
check_c_source_compiles("
    __thread int global = 0;
    int main() {
        global = 2;
        return 0;
    }
    "
    HAS_THREAD
)
check_c_source_compiles("
    int main() {
        __int128 a;
        __uint128_t b;
    }
    "
    HAS_UINT128
)
cmake_pop_check_state()

list(
    APPEND
    WIGXJPF_AUTO_CONFIG_DEFINITIONS
    "CMAKE_BUILD_SYSTEM"
)
if(HAS_LONG_DOUBLE)
    list(
        APPEND
        WIGXJPF_AUTO_CONFIG_DEFINITIONS
        "WIGXJPF_IMPL_LONG_DOUBLE=1"
    )
endif()
if(HAS_FLOAT128)
    list(
        APPEND
        WIGXJPF_AUTO_CONFIG_DEFINITIONS
        "WIGXJPF_IMPL_FLOAT128=1"
    )
endif()
if(HAS_THREAD)
    list(
        APPEND
        WIGXJPF_AUTO_CONFIG_DEFINITIONS
        "WIGXJPF_HAVE_THREAD=1"
    )
endif()
if(HAS_UINT128)
    list(
        APPEND
        WIGXJPF_AUTO_CONFIG_DEFINITIONS
        "MULTI_WORD_INT_SIZEOF_ITEM=8"
    )
endif()