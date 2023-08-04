#! /bin/bash

PORT=${1:-9000}
clickhouse-client --port $PORT --queries-file metaphone.sql
clickhouse-benchmark --port $PORT < benchmark.sql
