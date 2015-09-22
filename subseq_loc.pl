#!/usr/bin/perl -w

# Search a list of sequences, one sequecne per rowm,  against a fasta file 
# and return the location of each sequence


use Getopt::Long;
use strict;
use Bio::Seq;
use Bio::SeqIO;


my %opt;
            
GetOptions(\%opt, "contig=s", "subseq=s");

die "ERROR: must use '--contig' and '--subseq' to set name of your sequence files"
  unless ($opt{contig} || $opt{subseq}) ;


my $contig  = Bio::SeqIO->new('-file' => $opt{contig}, 
                        '-format' => 'Fasta'); 

my $subseq  = open(S, $opt{subseq}) or die $!;
my @subseq = <S>;
chomp @subseq;


while (my $contig_obj = $contig->next_seq()){

    foreach my $subseq  (@subseq){
	my $start = 0;
	
	$start = index($contig_obj->seq(),
		       $subseq,
	    );
	
	print join("\t",
		   $contig_obj->display_id(),
		   $subseq,
		   $start,
		   $start  + length($subseq) - 1,
	    ), "\n" if ($start >= 0);


	while($start = index($contig_obj->seq(), 
			     $subseq, 
			     $start+1)){
	    last if ($start == -1);
	    print join("\t", 
		       $contig_obj->display_id(),
		       $subseq,
		       $start, 
		       $start  +  length($subseq) - 1,
		       ), "\n";
	    
	}
    }
}
       
