#!/usr/bin/env perl
########################################################################
# Copyright (C) 2012, Charles Boyd
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
########################################################################
# Written on 11/08/2012 by Charles Boyd
# Modified on 11/08/2012 by Charles Boyd
########################################################################

use warnings;
use strict;

use Math::Trig;

my $radius = $ARGV[0];

unless ( $radius ) { $radius = 1 ; }

sub gen_curve {
  my @curve = ();
  my $t = 0;
  while ( $t < 2*pi ) {
    push @curve, [ gen_coordinates($radius, $t) ];
    $t += pi/12;
  }
  return @curve;
}

sub gen_coordinates {
  my ( $radius, $time ) = @_;
  my $x = ($radius * ($time - sin($time)));
  my $y = ($radius * (1 - cos($time)));
  return ($x, $y);
}

sub riemann_sum {
  my @curve = @_;
  my $sum = 0;
  for my $i ( 1 .. $#curve ) {
    my ($x1, $y1) = @{$curve[$i]};
    my ($x0, $y0) = @{$curve[$i-1]};
    my $midpoint = (1/2) * ($y0 + $y1);
    my $dx = ($x1 - $x0);
    my $area = ($midpoint * $dx);
    $sum += int($area);
  }
  return $sum;
}

sub print_curve {
  my @curve = @_;
  foreach my $aref ( @curve ) {
    print "\t [ @$aref ]\n";
  }
}

sub generate_cycloid {
  my @curve = gen_curve();
  print_curve(@curve);

  my $sum = riemann_sum(@curve);
  my $integral = (3 * pi * ($radius ** 2));

  print "estimated area  = $sum","\n";
  print "actual area = $integral", "\n";
}

generate_cycloid();

#EOF
