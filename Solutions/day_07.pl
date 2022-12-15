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
use Elves::GetData qw/ :all /;
use Elves::Reports qw/ :all /;
use feature "refaliasing";
use List::Util qw/ sum  first /;
no warnings qw( experimental::for_list experimental::refaliasing );

my $VERSION = '0.22.07';

my $result;

my @lines = @{( read_lined_table $main::puzzle_data_file)[0]};
my $fs = {
    '.' => '/',
    '..' => undef,
    dirs => {},
    files => {},
};
my $size_list = [];
my @trap_list;
sub addDir {
    my ( $curr_dir, $new_dir ) = @_;
    $curr_dir->{'dirs'}->{$new_dir} = {
        '..' => $curr_dir,
        '.' => $new_dir,
        dirs => {},
        files => {},
    };
    return $curr_dir;
}
sub addFile {
    my ( $curr_dir, $file_name, $file_size ) = @_;
    $curr_dir->{'files'}->{$file_name} = $file_size;
}
sub enterDir {
    my ( $curr_dir, $new_dir ) = @_;
    $curr_dir = $curr_dir->{'dirs'}{$new_dir};
    return $curr_dir;
}
sub leaveDir {
    my ( $curr_dir ) = @_;
    return $curr_dir->{'..'};
}
sub dirSize {
    my ( $curr_dir ) = @_;
    my $dir_size = 0;
    for my ( $name, $size ) ( %{$curr_dir->{'files'}} ) {
        $dir_size += $size;
    }
    foreach my $sub_dir ( keys %{$curr_dir->{'dirs'}} ) {
        ( $dir_size ) += dirSize( $curr_dir->{'dirs'}{$sub_dir} );
    }
    push @{$size_list}, $dir_size;
    push @trap_list, $dir_size if (100_000 >= $dir_size);
    return $dir_size;
}

sub doCmd {
    my ($curr_dir, $cmd, $dir) = @_;
    return $curr_dir if ( 'ls' eq $cmd );
    if ( '/' eq $dir ) {
        $curr_dir = $fs unless ( defined $curr_dir );
        while ( defined $curr_dir->{'..'} ) {
            $curr_dir = $curr_dir->{'..'};
        }
    } else {
        if ( '..' eq $dir ) {
            $curr_dir = leaveDir( $curr_dir );
        } else {
            $curr_dir = enterDir( $curr_dir, $dir );
        }
    }
    return $curr_dir;
}
sub addFiles {
    my ($p, $f, $s) = @_;
}
my $curr_dir = undef;
LINE:
for \my @tokens (@lines) {
    if ( '$' eq $tokens[0] )   { $curr_dir = doCmd( $curr_dir, @tokens[1, 2] ); next LINE; }
    if ( 'dir' eq $tokens[0] ) { $curr_dir = addDir( $curr_dir, $tokens[1] ); next LINE; }
    addFile( $curr_dir, @tokens[1,0] );
}

report_loaded;

# Part 1

my $fs_used = dirSize( $fs );
report_number(1, sum(@trap_list));

return unless $main::do_part_2;
# Part 2
$size_list = [sort {$a<=>$b} @{$size_list}];
my $needed_space = 30_000_000 - (70_000_000 - $fs_used);
report_number(2, first { $_ >= $needed_space } @{$size_list});


1;
# Vim: syntax=perl ts=4 sts=4 sw=4 et sr:
