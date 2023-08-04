#!/bin/bash

cat symspell.sql metaphone.sql test.sql > _test_run.sql
clickhouse-local --queries-file=_test_run.sql
rm _test_run.sql

