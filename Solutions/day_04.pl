#! /usr/bin/env perl
# SPDX-License-Identifier: MIT

########################################################################
#                                                                      #
#  This file is part of the solution set for the programming puzzles   #
#  presented by the 2021 Advent of Code challenge.                     #
#  See: https://adventofcode.com/2022                                  #
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
use Elves::GetData qw( :all );
use Elves::Reports qw( :all );

my $VERSION = '0.22.04';

my $result;

my @pair_list= read_lines $main::puzzle_data_file;

report_loaded;

# Part 1
sub sectionCovered {
    my ($left_start, $left_end, $right_start, $right_end) = ( map { split /-/, $_; } split /,/, shift);
    return (
        ( $left_start <= $right_start && $right_end <= $left_end ) ||
        ( $right_start <= $left_start && $left_end <= $right_end)
    );
}

$result = 0;
foreach my $assignment (@pair_list) {
    $result ++ if ( sectionCovered($assignment) );
}
report_number(1, $result);

exit unless $main::do_part_2;
# Part 2
sub sectionOverlap {
    my ($left_start, $left_end, $right_start, $right_end) = ( map { split /-/, $_; } split /,/, shift);
    return (
        ( $left_start <= $right_start && $right_start <= $left_end ) ||
        ( $right_start <= $left_start && $left_start <= $right_end)
    );
}

$result = 0;
foreach my $assignment (@pair_list) {
    $result ++ if ( sectionOverlap($assignment) );
}
report_number(2, $result);

    
1;
# Vim: syntax=perl ts=4 sts=4 sw=4 et sr:
