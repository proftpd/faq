#!/usr/bin/perl

$filename = shift @ARGV;
$CVSROOT = "/home/mark/Proftpd/www.proftpd.net/docs/";

if( $filename eq "" )
{
	print "Bomb!\n";
	exit(0);
}

$outfile = $CVSROOT . $filename;
$outfile =~ s/\.html$/.epl/;

print "Doing $filename -> $outfile\n";

open( INFILE, "<$filename" ) || die "can't open $filename";
open( OUTFILE, ">$outfile" ) || die "can't open $outfile";

$body=0;

print OUTFILE "\n\n#include \"header-simple.epl\"\n\n";

while( <INFILE> )
{
	if( /<BODY>/ || /<\/BODY>/ )
	{
		if( $body ) {
			$body=0;
		} else {
			$body=1;
		}
	} else {
		if( $body )
			{ print OUTFILE $_; }
	}
}

print OUTFILE "\n\n#include \"footer-simple.epl\"\n\n";

