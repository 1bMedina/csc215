struct bigint {
    char negative;
    char numdigits;
    char* digits;
};

void set_bigint();
char* get_bigint();

void add_bigints(
    struct bingint *a,
    struct bigint *b,
    struct bigint *result
);
