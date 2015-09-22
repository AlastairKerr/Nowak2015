#!/usr/bin/perl -w
#
# USAGE: rand_seq.pl --in <file1> --out <file3> --length <file4>

# Reads a sequence from file1 in fasta format 
# Randomises the sequence using all  available bases
# Prints output


use strict;
use Getopt::Long;
use Bio::Seq;
use Bio::SeqIO;

my %opt;
my %cutsites;

$opt{length} = 220;
$opt{number} = 100;
GetOptions(\%opt, "in=s", "out=s", "number=i", "length=i");

die "ERROR: must use '--in' to set name of your sequence files"
    unless ($opt{in}) ;

die "ERROR: must use '--out' to set name of your sequence files"
    unless ($opt{out}) ;


my $in = Bio::SeqIO->newFh(-file => $opt{in},-format=>'Fasta');
my $out = open(OUT, ">" . $opt{out}) or die "cannot write to $opt{out}";
my $all_seq;

while(my $seqobj  = <$in>){ # merge all  sequences
   $all_seq .= $seqobj->seq;
} 


foreach my $count (1..$opt{number}){
    my $title = ">RAND_" . $count . "\n"; # print
    my $new_seq = &rand_seq($all_seq);
    die "error" unless length($new_seq);
    my $tidy = &tidy_seq($new_seq);
    my $p = $title . $tidy;
    print OUT "$p\n";
}


#sandomly sample the sequence 
sub  rand_seq{ 
    my $seq = shift;
    my @seq = split //, $seq;
    my $new;
    my $len = length($seq);
    die "no seq in rand_seq" unless $len;
    foreach(1..$opt{length} ){
	my $pos = int(rand($#seq +0.5));
	$new .= $seq[$pos];
    }
    return($new);
}


sub tidy_seq{                   #adds a new line character every 60 bases  
    my ($seq) = @_;
    my ($new_seq) = "";
    my ($start,$end);
    my ($seq_len) = length($seq);
    my ($to_add) = int($seq_len/60);

    $end = $start= 0;

    foreach (1..$to_add){
        $new_seq .= substr($seq,$start,60);
        $new_seq .= "\n";
        $start += 60;
    }
    $new_seq .= substr($seq,$start);
    return ($new_seq);
}

    

  
