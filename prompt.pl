#! /usr/bin/perl -w

use Color::Output;
Color::Output::Init;

# adjust the path to your facts file accordingly
open(MYINPUTFILE, "</Users/linse/Documents/cloned/anki-prompt/pagetext.txt"); # open for input
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

# print one out of the first 100 ones, randomly
printHanzi($hanzi_list[rand 100]);

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
  cprint ("\x034$input\x030");
}
