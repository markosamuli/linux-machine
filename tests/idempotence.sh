#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
PROJECT_ROOT=$(dirname "$DIR")

total=0
passed=0
failed=0

# Print error into STDERR
error() {
    echo "$@" 1>&2
}

# Run setup without installing roles or dependencies
run_setup() {
    local tag=$1
    local success=0
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    echo "Run setup with tag: ${tag}"
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    total=$((total + 1))
    ./setup -q -t "${tag}" |
        tee /dev/tty |
        grep -q 'changed=0.*failed=0' && success=1
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    if [ "${success}" -eq "1" ]; then
        echo "Idempotence test: pass with tag ${tag}"
        passed=$((passed + 1))
        return 0
    else
        echo "Idempotence test: fail with tag ${tag}"
        failed=$((failed + 1))
        return 1
    fi
}

# Parse tags from the main.yml playbook file
get_playbook_tags() {
    ./tests/playbook-tags.py playbooks/main.yml || {
        error "Something went wrong while trying to get playbook tags"
        exit 1
    }
}

cd "${PROJECT_ROOT}" || {
    error "Couldn't find ${PROJECT_ROOT}"
    exit 1
}

PLAYBOOK_TAGS=$(get_playbook_tags)
for tag in ${PLAYBOOK_TAGS}; do
    run_setup "$tag"
done

printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -

if [ "$failed" -gt "0" ]; then
    echo "$failed / $total idempotence tests failed"
    exit 1
fi

if [ "$passed" -lt "$total" ]; then
    echo "$passed / $total idempotence tests passed"
    exit 1
fi

echo "All $passed / $total idempotence tests passed"
