#!/bin/bash
c=`consul kv get test/counter`
c=$((c + 1))
consul kv put test/counter $c
