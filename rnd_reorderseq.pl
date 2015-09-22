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
while(my $seqobj  = <$in>){ # read each sequence in file
   $all_seq .= create_seq($seqobj->seq);
} 


foreach my $count (1..$opt{number}){
    my $title = ">RAND_" . $count. "\n"; # print
    my $pre = &create_seq($all_seq);
    my $new_seq = &rand_seq($pre);
    print OUT "$title", &tidy_seq($new_seq), "\n";    
}

sub create_seq{
    my $seq = shift;
    $seq =~ tr/atgc/ATGC/;
    my $T = $seq =~ tr/T/T/;
    my $A = $seq =~ tr/A/A/;
    my $G = $seq =~ tr/G/G/;
    my $C = $seq =~ tr/C/C/;
    my $total  =  $T+$C+$G+$A;
    my $nseq = "T" x  int($opt{length} * ($T/$total));
    $nseq   .= "A" x  int($opt{length} * ($A/$total));
    $nseq   .= "C" x  int($opt{length} * ($C/$total));
    $nseq   .= "G" x  int($opt{length} * ($G/$total));
    return($nseq);
}

sub  rand_seq{
# reorders the sequence
    my $seq = shift;
    my @seq = split //, $seq;
    my $new;
    while(@seq){
	my $aa = splice(@seq, int (rand($#seq +0.5)), 1);
	$new .= $aa;
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

    

  
