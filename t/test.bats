#!/usr/bin/env bats

load helper

@test 'unknown continue' {
    run git switch foo

    run git continue

    assert_failure
    assert_output "git continue: don't know how to '--continue' current state"
}

@test 'unknown abort' {
    run git switch foo

    run git abort

    assert_failure
    assert_output "git abort: don't know how to '--abort' current state"
}

@test 'merge continue' {
    run git switch foo
    run git merge bar
    run git checkout --theirs .
    run git add -u

    run git continue

    assert_success
    assert_file_contains "$f" bar
}

@test 'merge abort' {
    run git switch foo
    run git merge bar

    run git abort

    assert_success
    assert_file_contains "$f" foo
}

@test 'rebase continue' {
    # Paradox: rebase foo onto bar, then discard all of foo's changes. This is
    # the only way to differentiate the --continue/--abort outcomes because
    # --abort returns to the checked-out branch.
    run git rebase bar foo
    run git checkout --ours .
    run git add -u

    run git continue

    assert_success
    assert_file_contains "$f" bar
}

@test 'rebase abort' {
    run git rebase bar foo

    run git abort

    assert_success
    assert_file_contains "$f" foo
}

@test 'am continue' {
    p=0001-bar-change.patch

    run git switch foo
    run git format-patch bar -1
    run git am $p
    # I'm not sure how to correctly, easily fix the patch, so instead we just
    # add the patch itself, then assert "am" completes successfully and that
    # the repo contains the newly added patch file.
    run git add $p

    run git continue

    assert_success
    assert_file_contains "$f" foo

    run git ls-files
    assert_output --partial $p
}

@test 'am abort' {
    p=0001-bar-change.patch

    run git switch foo
    run git format-patch bar -1
    run git am $p

    run git abort

    assert_success
    assert_file_contains "$f" foo

    run git ls-files
    refute_output --partial $p
}

@test 'revert continue' {
    run git switch foo
    run git checkout bar -- .
    run git commit --quiet -m 'obstruct revert'

    assert_file_contains "$f" bar

    run git revert HEAD~
    run git checkout --theirs .
    run git add -u

    run git continue

    assert_success
    assert_file_contains "$f" initial
}

@test 'revert abort' {
    run git switch foo
    run git checkout bar -- .
    run git commit --quiet -m 'obstruct revert'

    assert_file_contains "$f" bar

    run git revert HEAD~

    run git abort

    assert_success
    assert_file_contains "$f" bar
}

@test 'cherry-pick continue' {
    run git switch foo
    run git cherry-pick bar
    run git checkout --theirs .
    run git add -u

    run git continue

    assert_success
    assert_file_contains "$f" bar
}

@test 'cherry-pick abort' {
    run git switch foo
    run git cherry-pick bar
    run git checkout --theirs .
    run git add -u

    run git abort

    assert_success
    assert_file_contains "$f" foo
}
