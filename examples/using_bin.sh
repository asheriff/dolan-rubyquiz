#!/usr/bin/env sh

#
# Find unique substrings
#
./bin/unique_substring_finder spec/data/test_words

#
# Find unique substrings of length 3
#
./bin/unique_substring_finder -s3 spec/data/test_words

#
# Set field separator in output
#
./bin/unique_substring_finder -F: spec/data/test_words
