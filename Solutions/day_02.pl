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

my $VERSION = '0.22.02';

my $result;
my $depth_index;

my @play_list= read_lines $main::puzzle_data_file;
my $scores = {
    A => { qw/r 4 p 8 s 3/ },
    B => { qw/r 1 p 5 s 9/ },
    C => { qw/r 7 p 2 s 6/ },
};
my $plays = [
    [0,0,0],
    [0,0,0],
    [0,0,0],
];
my %elf_play = (
    A => 0,
    B => 1,
    C => 2,
);
my %me_trans = (
    X => 'r',
    Y => 'p',
    Z => 's',
);
my %me_play = (
    r => 0,
    p => 1,
    s => 2,
);

report_loaded;

# Part 1
$result = 0;
foreach my $play (@play_list) {
    my ($elf, $me) = split " ", $play;
    $plays->[ $elf_play{$elf} ][ $me_play{$me_trans{$me}} ] ++;
}
foreach my $me (keys %me_play) {
    foreach my $elf (keys %elf_play) {
        $result += $scores->{ $elf }{ $me } * $plays->[ $elf_play{$elf} ][ $me_play{$me} ];
    }
}
report_number(1, $result);

exit unless $main::do_part_2;
# Part 2
$result = 0;
$plays = [
    [0,0,0],
    [0,0,0],
    [0,0,0],
];
%me_trans = (
    X => { qw/A s B r C p/ },
    Y => { qw/A r B p C s/ },
    Z => { qw/A p B s C r/ },
);
foreach my $play (@play_list) {
    my ($elf, $me) = split " ", $play;
    $plays->[ $elf_play{$elf} ][ $me_play{$me_trans{$me}{$elf}} ] ++;
}
foreach my $me (keys %me_play) {
    foreach my $elf (keys %elf_play) {
        $result += $scores->{ $elf }{ $me } * $plays->[ $elf_play{$elf} ][ $me_play{$me} ];
    }
}
report_number(2, $result);

    
1;
# Vim: syntax=perl ts=4 sts=4 sw=4 et sr:
