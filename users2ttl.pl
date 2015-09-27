# Convert http://grouplens.org/datasets/movielens/ users file to Turtle
# typical input line:
# 6::F::50::9::55117
# UserID::Gender::Age::Occupation::Zip-code

print "\@prefix glschema: <http://learningsparql.com/grouplens/schema/> .\n";
print "\@prefix gldu: <http://learningsparql.com/grouplens/data/user/> .\n";
print "\@prefix gldo: <http://learningsparql.com/grouplens/data/occupation/> .\n";
print "\@prefix glda: <http://learningsparql.com/grouplens/data/age/> .\n";
print "\@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .\n";
print "\@prefix schema: <http://schema.org/> .\n";
print "\@prefix dcterms: <http://purl.org/dc/terms/> .\n\n";

while(<>) {
    chop($_);
    my @line = split(/::/,$_);

    my $userQname = "gldu:i" . $line[0];
    my $gender = $line[1];
    my $ageCode = $line[2];
    my $occupationCode = $line[3];
    my $postalCode = $line[4];

    print "$userQname a schema:Person ;\n";
    print "  schema:gender \"$gender\" ;\n";
    print "  glschema:age glda:i$ageCode ;\n";
    print "  schema:jobTitle gldo:i$occupationCode ;\n";
    print "  schema:postalCode \"$postalCode\" .\n\n";
        
}

