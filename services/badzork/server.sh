#!/bin/bash
socat TCP-LISTEN:2000,fork EXEC:./badzork.guile 
