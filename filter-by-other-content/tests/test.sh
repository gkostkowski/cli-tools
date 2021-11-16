setup_suite() {
    SCRIPT_DIR="$(dirname ${BASH_SOURCE[0]})"
    TEST_DATA_DIR="${SCRIPT_DIR}/data"
}

setup() {
    OUT_FILE=$(mktemp)
}

teardown() {
    rm "$OUT_FILE"
}

test_simple_txt_match_01() {
    EXPECTED=$(cat <<EOF
aa 1 4
cc 2 5
EOF
    )
    ../filter_by_other_content \
        -i="$TEST_DATA_DIR"/file02.txt \
        -f="$TEST_DATA_DIR"/file04.txt \
        -c=2 \
        -t=1 \
        -d=' ' \
        -o="$OUT_FILE" > /dev/null
    assert_equals "$EXPECTED" "$(<$OUT_FILE)"
}

test_simple_txt_match_02() {
    EXPECTED=$(cat <<EOF
bb 4 1
a 5 2
c 6 3
EOF
    )
    ../filter_by_other_content \
        -i="$TEST_DATA_DIR"/file02.txt \
        -f="$TEST_DATA_DIR"/file04.txt \
        -c=2 \
        -t=2 \
        -d=' ' \
        -o="$OUT_FILE" > /dev/null
    assert_equals "$EXPECTED" "$(<$OUT_FILE)"
}

test_simple_txt_match_03() {
    EXPECTED=$(cat <<EOF
bb 4 1
a 5 2
c 6 3
dd 7 3
EOF
    )
    ../filter_by_other_content \
        -i="$TEST_DATA_DIR"/file02.txt \
        -f="$TEST_DATA_DIR"/file04.txt \
        -c=3 \
        -t=1 \
        -d=' ' \
        -o="$OUT_FILE" > /dev/null
    assert_equals "$EXPECTED" "$(<$OUT_FILE)"
}

test_txt_match_diff_col_no_01() {
    EXPECTED=$(cat <<EOF
1
2
3
3 4 3
EOF
    )
    ../filter_by_other_content \
        -i="$TEST_DATA_DIR"/file01.txt \
        -f="$TEST_DATA_DIR"/file04.txt \
        -c=1 \
        -t=1 \
        -d=' ' \
        -o="$OUT_FILE" > /dev/null
    assert_equals "$EXPECTED" "$(<$OUT_FILE)"
}

test_txt_match_diff_col_no_02() {
    EXPECTED=$(cat <<EOF
1 4
2 5
3 6
EOF
    )
    ../filter_by_other_content \
        -i="$TEST_DATA_DIR"/file04.txt \
        -f="$TEST_DATA_DIR"/file01.txt \
        -c=1 \
        -t=1 \
        -d=' ' \
        -o="$OUT_FILE" > /dev/null
    assert_equals "$EXPECTED" "$(<$OUT_FILE)"
}

test_txt_match_diff_col_no_03() {
    EXPECTED=$(cat <<EOF
3 6
EOF
    )
    ../filter_by_other_content \
        -i="$TEST_DATA_DIR"/file04.txt \
        -f="$TEST_DATA_DIR"/file01.txt \
        -c=1 \
        -t=3 \
        -d=' ' \
        -o="$OUT_FILE" > /dev/null
    assert_equals "$EXPECTED" "$(<$OUT_FILE)"
}

test_tsv_no_match_01() {
    EXPECTED=''
    ../filter_by_other_content \
        -i="$TEST_DATA_DIR"/file04.txt \
        -f="$TEST_DATA_DIR"/file03.tsv \
        -c=1 \
        -t=2 \
        -d=$'\t' \
        -o="$OUT_FILE" > /dev/null
    assert_equals "$EXPECTED" "$(<$OUT_FILE)"
}

test_tsv_match_02() {
    EXPECTED=$(cat <<EOF
aa	1
cc	2
b	3 4 3	c
EOF
    )
    ../filter_by_other_content \
        -i="$TEST_DATA_DIR"/file03.tsv \
        -f="$TEST_DATA_DIR"/file01.txt \
        -c=2 \
        -t=1 \
        -d=$'\t' \
        -o="$OUT_FILE" > /dev/null
    assert_equals "$EXPECTED" "$(<$OUT_FILE)"
}

test_mixed_tab_delim_01() {
    EXPECTED=''
    ../filter_by_other_content \
    -i="$TEST_DATA_DIR"/file03.tsv \
    -f="$TEST_DATA_DIR"/file02.txt \
    -c=2 \
    -t=2 \
    -d=$'\t' \
    -o="$OUT_FILE" > /dev/null
    assert_equals "$EXPECTED" "$(<$OUT_FILE)"
}

test_mixed_space_delim_02() {
    # Note: By space it understand any space character (tabulation too)
    EXPECTED=''
    ../filter_by_other_content \
    -i="$TEST_DATA_DIR"/file03.tsv \
    -f="$TEST_DATA_DIR"/file02.txt \
    -c=2 \
    -t=2 \
    -d=' ' \
    -o="$OUT_FILE" > /dev/null
    assert_equals "$EXPECTED" "$(<$OUT_FILE)"
}

test_mixed_space_delim_02() {
    # Note: By space it understand any space character (tabulation too)
    EXPECTED=$(cat <<EOF
aa	1
bb	4
a	5
c	6
cc	2
3 4 3	a
EOF
    )
    ../filter_by_other_content \
    -i="$TEST_DATA_DIR"/file03.tsv \
    -f="$TEST_DATA_DIR"/file02.txt \
    -c=2 \
    -t=2 \
    -d=' ' \
    -o="$OUT_FILE" > /dev/null
    assert_equals "$EXPECTED" "$(<$OUT_FILE)"
}

test_mixed_guessed_delim_03() {
    # Note: Uses any space; by space it understand any space character (tabulation too)
    EXPECTED=$(cat <<EOF
aa	1
bb	4
a	5
c	6
cc	2
3 4 3	a
EOF
    )
    ../filter_by_other_content \
    -i="$TEST_DATA_DIR"/file03.tsv \
    -f="$TEST_DATA_DIR"/file02.txt \
    -c=2 \
    -t=2 \
    -o="$OUT_FILE" > /dev/null
    assert_equals "$EXPECTED" "$(<$OUT_FILE)"
}

test_mixed_guessed_delim_04() {
    # Note: Uses any space; by space it understand any space character (tabulation too)
    EXPECTED=$(cat <<EOF
aa	1
bb	4
a	5
cc	2
3 4 3	a
b	3 4 3	c
EOF
    )
    ../filter_by_other_content \
    -i="$TEST_DATA_DIR"/file03.tsv \
    -f="$TEST_DATA_DIR"/file02.txt \
    -c=2 \
    -t=3 \
    -o="$OUT_FILE" > /dev/null
    assert_equals "$EXPECTED" "$(<$OUT_FILE)"
}
