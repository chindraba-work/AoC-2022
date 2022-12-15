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
use List::Util::XS;
use List::Util qw/sum/;

my $VERSION = '0.22.03';

my $result;

my @pack_list= read_lines $main::puzzle_data_file;

sub priority {
    return ord($_[0]) - ord("a") + ( ( $_[0] eq uc $_[0] ) ? 59 : 1 );
}

report_loaded;

# Part 1
#
my @priors = map {
    my @chars = split //,$_;
    my $len = @chars;
    my $mid = $len / 2 ;
    my @left = @chars[0..$mid-1];
    my @right = @chars[$mid..$#chars];
    my $lv = 0;
    my $rv = 0;
    foreach my $ch (@right) {
        $rv |= 2 ** priority($ch);
    }
    foreach my $ch (@left){
        $lv |= 2 ** priority($ch);
    }
    log($rv & $lv)/log(2);
} @pack_list;

$result = sum(@priors);
report_number(1, $result);

# perl -e '

exit unless $main::do_part_2;
sub badges {
    my @list;
    push @list, log(shift(@_) & shift(@_) & shift(@_))/log(2) while (scalar @_);
    return @list;
}
my @contents = map {
    my $prior = 0;
    foreach my $ch (split //,$_) {
        $prior |= 2 ** priority($ch);
    }
    $prior;
} @pack_list;

# Part 2
$result = sum(badges(@contents));
report_number(2, $result);

    
1;
# vim: syntax=perl ts=4 sts=4 sw=4 et sr:
