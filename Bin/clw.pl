#!/usr/bin/env perl

use File::Basename;
use Getopt::Long qw(:config no_ignore_case pass_through);

my($prog) = fileparse($0, '\.\w*$');

my %opt;
GetOptions(\%opt, qw(MD MMD MF=s));

my @cmd = qw(cl /nologo);
push(@cmd, '/showIncludes') if $opt{MD} || $opt{MMD};
for (@ARGV) {
    push(@cmd, $_);
}
warn "+ @cmd\n";
my @output = qx(@cmd);
if ($?) {
    print STDERR @output;
    exit(2);
}

my $rc = 0;

if ($opt{MD} || $opt{MMD}) {
    my %rawdeps;
    for (@output) {
	if (m%^Note:\s+including file:\s+(\S+)%) {
	    $rawdeps{$1}++;
	} else {
	    print;
	}
    }
    my @deps = sort { length($a) <=> length($b) } keys %rawdeps;
    chomp @deps;
    my @cfiles = grep m%\.c$%, @ARGV;
    unshift(@deps, @cfiles);
    my @ofiles = map { s%\.c$%.obj%; $_ } @cfiles;
    my $limit = 60;
    my $line = "@ofiles:";
    if (my $dfile = $opt{MF}) {
	open(DEPS, '>', $dfile) || die "$prog: Error: $dfile: $!\n";
	select DEPS;
    }
    for my $dep (@deps) {
	if ((length($line) + length($dep) > $limit)) {
	    print "$line \\\n ";
	    $line = '';
	}
	$line .= " $dep";
    }
    print $line;
} else {
    print STDOUT @output;
}

exit($rc != 0);
