#!/usr/bin/env perl

# SPDX-License-Identifier: MIT

########################################################################
#                                                                      #
#  This file is part of the solution set for the programming puzzles   #
#  presented by the 2022 Advent of Code challenge.                     #
#  See: https://adventofcode.com/2021                                  #
#                                                                      #
#  Copyright © 2022  Chindraba (Ronald Lamoreaux)                      #
#                    <aoc@chindraba.work>                              #
#  - All Rights Reserved                                               #
#                                                                      #
#  Permission is hereby granted, free of charge, to any person         #
#  obtaining a copy of this software and associated documentation      #
#  files (the "Software"), to deal in the Software without             #
#  restriction, including without limitation the rights to use, copy,  #
#  modify, merge, publish, distribute, sublicense, and/or sell copies  #
#  of the Software, and to permit persons to whom the Software is      #
#  furnished to do so, subject to the following conditions:            #
#                                                                      #
#  The above copyright notice and this permission notice shall be      #
#  included in all copies or substantial portions of the Software.     #
#                                                                      #
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,     #
#  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF  #
#  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND               #
#  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS #
#  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN  #
#  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN   #
#  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE    #
#  SOFTWARE.                                                           #
#                                                                      #
########################################################################

use 5.030000;
use strict;
use warnings;
use Time::HiRes;
use lib ".";
use lib "./../AoC-Common";

our $aoc_year = 2022;
our $use_live_data = 1;
our $do_part_2 = 1;

our @start_time;
exit unless ( @ARGV );

our $challenge_day = shift @ARGV;

my $solution_file = sprintf "Solutions/day_%02d", $challenge_day;
our $puzzle_data_file = sprintf "Data/%s_%02d.txt", $use_live_data ? 'day' : 'sample', $challenge_day;
my $second_file = sprintf "Data/sample_%02d_2.txt", $challenge_day;

if ( !$use_live_data && [ -f $second_file ]) {
    our $puzzle_data_file2 = $second_file;
}

if ( @ARGV ) {
    my $challenge_part = shift @ARGV;
    $solution_file = sprintf "Solutions/day_%02d_%s.pl", $challenge_day, lc($challenge_part);
} elsif ( -f sprintf("Solutions/day_%02d.pl", $challenge_day) ) {
    $solution_file = sprintf "Solutions/day_%02d.pl", $challenge_day;
} elsif ($do_part_2) {
    $solution_file = sprintf "Solutions/day_%02d_%s.pl", $challenge_day, 'b';
} else {
    $solution_file = sprintf "Solutions/day_%02d_%s.pl", $challenge_day, 'a';
}

do {
    push @start_time, [Time::HiRes::gettimeofday()];
    unless (my $return = do $solution_file) {
        warn "$@" if $@;
    }
    printf "Advent of Code %4u, Day %2u processing completed in %.6f ms.\n\n", $aoc_year, $challenge_day, Time::HiRes::tv_interval($start_time[0]) * 1_000;
    exit;
} if ( -f $puzzle_data_file && -f $solution_file );

if ( -f $puzzle_data_file ) {
    say "The solutions for $challenge_day ($solution_file, $puzzle_data_file) seem to be incomplete.";
} else {
    say "There is no data for $challenge_day. Nothing can be done with out data.";
}

1;
# Vim: syntax=perl ts=4 sts=4 sw=4 et sr:
