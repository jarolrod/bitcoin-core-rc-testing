#!/bin/bash

run_tests() {
ls
  for f in ${TEST_DIR}/rpc-*.sh; do
    if ! "$f"; then
      echo "${FAILURE} Test could not run"
    fi
  done

}
