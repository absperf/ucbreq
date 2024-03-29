#!/bin/sh

set -euf

podman=$(command -v podman || command -v docker)

for version in 3.6 3.7 3.8 3.9 3.10 3.11; do
  for test in load dump; do
    echo $version $test
    "$podman" container run --rm -e PYTHONPATH=/app/src --mount type=bind,source=.,destination=/app --security-opt label=disable "python:$version" python -munittest "/app/test/test_$test.py"
  done
done
