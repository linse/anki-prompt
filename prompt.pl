#! /usr/bin/perl -w

# User configurable parameters:

my $TRAIN_FILE = "/Users/linse/Documents/cloned/anki-prompt/pagetext.txt";
my $TOP_ENTRIES = 100;


my $has_color = 0;
eval("use Color::Output");
if ($@) {
  use Term::ANSIColor;
}else{
  eval("Color::Output::Init");
  $has_color = 1;
}
use strict;

# adjust the path to your facts file accordingly
open(MYINPUTFILE, "<$TRAIN_FILE"); # open for input
my(@lines) = <MYINPUTFILE>; # read file into list

my(@hanzi_list);
my $hanzi="";
my($line);
my $number=0;
shift @lines; # skip first one
foreach $line (@lines) {
  if ($line =~ m/^\s+(\d+)(.+)/) {
	  if ($hanzi ne "") {
		  push(@hanzi_list, $hanzi);
	  }
	  $hanzi = "";
	  $hanzi .= $2;
  }
  else {
  	$line =~ s/\s+$//;
  	chomp $line;
  	$hanzi .= $line;
  }  
}
close(MYINPUTFILE);

# print one out of the first $TOP_ENTRIES ones, randomly
printHanzi($hanzi_list[rand $TOP_ENTRIES]);

# possibly adjust to the formatting of your facts 
sub printHanzi {
  my $input = shift;
  while ($input =~ m/^\s*(\S*)\s*(\[\S+\])\s+([^\[]*)(.*)/) {
	print("$1 ");
	printRed("$2 ");
	chomp($3);
	print "$3";
	$input = $4;
	print "\n";
  }
}

sub printRed {
  my $input = shift;
  if ($has_color) {
    cprint ("\x034$input\x030");
  } else{ 
    print color 'red';
    print $input;
    print color 'reset';
  }
}
