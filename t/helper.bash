f=conflict.txt

init_repo()
{
    PATH="$BATS_TEST_DIRNAME/..:$PATH"

    git init --quiet --initial-branch=main "$BATS_TMPDIR/repo"
    cd "$BATS_TMPDIR/repo" || exit
    git config user.email foo@bar.baz
    git config core.editor true
    printf 'initial\n' "$b" > "$f"
    git add "$f"
    git commit --quiet -m "Initial"
    for b in foo bar
    do
        git switch --create $b main
        printf '%s\n' "$b" > "$f"
        git add "$f"
        git commit --quiet -m "$b change"
    done
}

setup()
{
    init_repo
    load 'bats-support/load'
    load 'bats-assert/load'
    load 'bats-file/load'
}

teardown()
{
    rm -rf "$BATS_TMPDIR/repo"
}
