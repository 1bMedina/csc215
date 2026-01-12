#include "BIGINT.H"
#include "BDSCTEST.H"

main()
{
    struct bigint bi;
    struct bigint a;
    struct bigint b;
    struct bigint sum;
    struct bigint diff;

    START_TESTING("BIGINTTD.C");

    TEST_CASE("Read and write bigint 1234567");
    set_bigint("1234567", &bi);
    ASSERT_STR(get_bigint(bi), "1234567");

    TEST_CASE("Add two positive bigints");
    set_bigint("1234", &a);
    set_bigint("5678", &b);
    add_bigints(&a, &b, &sum);
    ASSERT_STR(get_bigint(sum), "6912");

    TEST_CASE("Add two positive bigints - 9999 + 9999");
    set_bigint("9999", &a);
    set_bigint("9999", &b);
    add_bigints(&a, &b, &sum);
    ASSERT_STR(get_bigint(sum), "19998");

    TEST_CASE("Subtract two positive bigints - 5678 - 1234");
    set_bigint("5678", &a);
    set_bigint("1234", &b);
    add_bigints(&a, &b, &diff);
    ASSERT_STR(get_bigint(diff), "4444");

    TEST_CASE("Subtract two positive bigints - 123 - 546");
    set_bigint("123", &a);
    set_bigint("546", &b);
    add_bigints(&a, &b, &diff);
    ASSERT_STR(get_bigint(diff), "-423");

    END_TESTING();
}
