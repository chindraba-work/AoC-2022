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
my $VERSION = '0.22.06';

my $result;

my $signal= (read_lines $main::puzzle_data_file)[0];

report_loaded;

# samples provided, uncomment the one to test

#$signal = 'mjqjpqmgbljsphdztnvjfqwrcgsmlb'; # 7
#$signal = 'bvwbjplbgvbhsrlpgdmjqwftvncz'; #: first marker after character 5
#$signal = 'nppdvjthqldpwncqszvftbrmjlhg'; #: first marker after character 6
#$signal = 'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg'; #: first marker after character 10
#$signal = 'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw'; #: first marker after character 11

my $leader = ($signal =~ m/^
    (.*?(.)
    (?!\2)(.)
    (?!\2|\3)
    (.)(?!\2|\3|\4)
    (.)
    )/x
)[0];

# Part 1
$result = length $leader;

report_number(1, $result);

return unless $main::do_part_2;
# Part 2
my $message = ($signal =~ m/^
    (.*?
    (.)(?!\2)
    (.)(?!\2|\3)
    (.)(?!\2|\3|\4)
    (.)(?!\2|\3|\4|\5)
    (.)(?!\2|\3|\4|\5|\6)
    (.)(?!\2|\3|\4|\5|\6|\7)
    (.)(?!\2|\3|\4|\5|\6|\7|\8)
    (.)(?!\2|\3|\4|\5|\6|\7|\8|\9)
    (.)(?!\2|\3|\4|\5|\6|\7|\8|\9|\10)
    (.)(?!\2|\3|\4|\5|\6|\7|\8|\9|\10|\11)
    (.)(?!\2|\3|\4|\5|\6|\7|\8|\9|\10|\11|\12)
    (.)(?!\2|\3|\4|\5|\6|\7|\8|\9|\10|\11|\12|\13)
    (.)(?!\2|\3|\4|\5|\6|\7|\8|\9|\10|\11|\12|\13|\14)
#   (.)(?!\2|\3|\4|\5|\6|\7|\8|\9|\10|\11|\12|\13|\14|\15)
    (.)
    )/x
)[0];

$result = length $message;

report_number(2, $result);

    
1;
# Vim: syntax=perl ts=4 sts=4 sw=4 et sr:
