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
use List::Util qw( zip sum reduce );
use List::MoreUtils qw( first_index last_index );

my $VERSION = '0.22.08';

# Initialization

my $result;
my $trees;
$trees = [ read_grid $main::puzzle_data_file ];
my $limit = $#{$trees};
my %level = (
    n => [ (-1) x ($limit + 1) ],
    s => [ (-1) x ($limit + 1) ],
    e => [ (-1) x ($limit + 1) ],
    w => [ (-1) x ($limit + 1) ],
);
my ($N, $S, $E, $W) = qw(1 4 2 8);
my $visible = [];
for (0..$limit) {
    push @{$visible}, ( [ (0) x ($limit + 1) ] );
}

report_loaded;

# Part 1
for ( my $loop = 0; $loop <= $limit; $loop++ ) {
    my $band = $limit - $loop;
    for ( my $step = $loop; $step <= $limit; $step++ ) {
        my $back = $limit - $step;
        unless ( 0 == $loop || 0 == $step ) {
            # Check scenic view
        }
        # Rows from North
        # check north visibility
        if ( $trees->[$loop][$step] > $level{'n'}[$step] ) {
            $level{'n'}[$step] = $trees->[$loop][$step];
            $visible->[$loop][$step] = 1;
        }
        # check west visibility
        if ( $trees->[$loop][$step] > $level{'w'}[$loop] ) {
            $level{'w'}[$loop] = $trees->[$loop][$step];
            $visible->[$loop][$step] = 1;
        }
        # check east visibility
        if ( $trees->[$loop][$back] > $level{'e'}[$loop] ) {
            $level{'e'}[$loop] = $trees->[$loop][$back];
            $visible->[$loop][$back] = 1;
        }

        # Columns from West
        # check west visibility
        if ( $trees->[$step][$loop] > $level{'w'}[$step] ) {
            $level{'w'}[$step] = $trees->[$step][$loop];
            $visible->[$step][$loop] = 1;
        }
        # check north visibility
        if ( $trees->[$step][$loop] > $level{'n'}[$loop] ) {
            $level{'n'}[$loop] = $trees->[$step][$loop];
            $visible->[$step][$loop] = 1;
        }
        # check south visibility
        if ( $trees->[$back][$loop] > $level{'s'}[$loop] ) {
            $level{'s'}[$loop] = $trees->[$back][$loop];
            $visible->[$back][$loop] = 1;
        }

        # Rows from South
        # check south visibility
        if ( $trees->[$band][$step] > $level{'s'}[$step] ) {
            $level{'s'}[$step] = $trees->[$band][$step];
            $visible->[$band][$step] = 1;
        }
        # check west visibility
        if ( $trees->[$band][$step] > $level{'w'}[$band] ) {
            $level{'w'}[$band] = $trees->[$band][$step];
            $visible->[$band][$step] = 1;
        }
        # check east visibility
        if ( $trees->[$band][$back] > $level{'e'}[$band] ) {
            $level{'e'}[$band] = $trees->[$band][$back];
            $visible->[$band][$back] = 1;
        }

        # Columns from East
        # check east visibility
        if ( $trees->[$step][$band] > $level{'e'}[$step] ) {
            $level{'e'}[$step] = $trees->[$step][$band];
            $visible->[$step][$band] = 1;
        }
        # check north visibility
        if ( $trees->[$step][$band] > $level{'n'}[$band] ) {
            $level{'n'}[$band] = $trees->[$step][$band];
            $visible->[$step][$band] = 1;
        }
        # check south visibility
        if ( $trees->[$back][$band] > $level{'s'}[$band] ) {
            $level{'s'}[$band] = $trees->[$back][$band];
            $visible->[$back][$band] = 1;
        }
    }
}

$result = sum( map { sum( @{$_} ); }(@{$visible}) );

report_number(1, $result);


exit unless $main::do_part_2;
# Part 2
my $forest;
my $forest1;
$forest = [ zip ( @{$trees} ) ];
$result = 0;
for ( my $loop = 1 ; $loop < $limit; $loop++ ) {
    for ( my $step = 1; $step < $limit; $step++ ) {
        my ( $view, @views );
        my $height = $trees->[$loop][$step];
        $view = last_index { $_ >= $height } @{$forest->[$step]}[0..( $loop - 1 )];
        $views[0] = ( -1 == $view ) ? $loop : $loop - $view;
        $view = first_index { $_ >= $height } @{$trees->[$loop]}[( $step + 1 )..$limit ];
        $views[1] = ( -1 == $view ) ? $limit - $step : $view + 1;
        $view = first_index { $_ >= $height } @{$forest->[$step]}[( $loop + 1 )..$limit];
        $views[2] = ( -1 == $view ) ? $limit - $loop : $view + 1;
        $view = last_index { $_ >= $height } @{$trees->[$loop]}[0..( $step -1 )];
        $views[3] = ( -1 == $view ) ? $step : $step - $view;
        $view = reduce { $a * $b } @views;
        $result = ( $view > $result ) ? $view : $result;
    }
}


report_number(2, $result);


1;
# Vim: syntax=perl ts=4 sts=4 sw=4 et sr:
