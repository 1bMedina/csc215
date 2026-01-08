#include "BIGINT.H"
#include "BDSCTEST.H"

main() {
    START_TESTING("BIGINTTD.C");

    TEST_CASE("Read and write bigint 1234567") {
        struct bigint bi;
        set_bigint("1234567", &bi);
        ASSERT_STR(get_bigint(bi), "1234567");
    }

    TEST_CASE("Add two positive bigints") {
        struct bigint a, b, sum;
        set_bigint('1234', &a);
        set_bigint('5678', &b);
        
        add_bigints(&a, &b, &sum);

        ASSERT_STR(get_bigint(sum), '6912')
    }

    END_TESTING();
}