#!/bin/bash
c=`/usr/local/bin/consul kv get test/counter`
c=$((c + 1))
/usr/local/bin/consul kv put test/counter $c
