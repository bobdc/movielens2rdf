# Convert http://grouplens.org/datasets/movielens/ movies file to Turtle
# typical input line:
# 4::Waiting to Exhale (1995)::Comedy|Drama
# MovieID::Title::Genres

use strict;

print "\@prefix gldm: <http://learningsparql.com/grouplens/data/movie/> .\n";
print "\@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .\n";
print "\@prefix schema: <http://schema.org/> .\n";
print "\@prefix dcterms: <http://purl.org/dc/terms/> .\n\n";

while(<>) {
    chop($_);
    my @line = split(/::/,$_);
    my $movieQname = "gldm:i" . $line[0];
    my $title = $line[1];
    my @categories = split(/\|/,$line[2]);
    # pull release year out of title (am I feature engineering yet?)
    $title =~ s/(.*) \((\d\d\d\d)\)/$1/;
    my $releaseYear = $2;
    # Move "The " from end to beginning (e.g. in "Shaggy Dog, The")
    $title =~ s/(.+), The/The $1/;

    print "$movieQname rdfs:label \"$title\" ;\n";
    print "  a schema:Movie ;";
    for (my $cat = 0; $cat < @categories; $cat++) {
        print   "  dcterms:type \"" . @categories[$cat] . "\" ;\n" ;
    }
    print "  schema:datePublished \"$releaseYear\" .\n\n";
}
