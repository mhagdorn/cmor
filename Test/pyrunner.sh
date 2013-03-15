#!/bin/bash
PYTHONPATH=..:$PYTHONPATH
python @name@ &> @name@.log || exit 1
