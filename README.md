# clickhouse-metaphone
The original Metaphone algorithm as a ClickHouse SQL UDF

Translated from this implementation: https://github.com/vividvilla/metaphone/

To run tests first install clickhouse-local and then run `./test.sh`
To run benchmark make sure to have clickhouse server running and then run `./benchmark.sh`
- if it's on a port other than 9000 you can pass it as an argument `./benchmark.sh 9001`
To install put the contents of metaphone.sql in a migration or run `clickhouse-client --queries-file metaphone.sql`
