# Convert http://grouplens.org/datasets/movielens/ ratings file to Turtle
# typical input line:
# 1::1197::3::978302268
# UserID::MovieID::Rating::Timestamp


print "\@prefix gldu: <http://learningsparql.com/grouplens/data/user/> .\n";
print "\@prefix gldm: <http://learningsparql.com/grouplens/data/movie/> .\n";
print "\@prefix schema: <http://schema.org/> .\n";
print "\@prefix dcterms: <http://purl.org/dc/terms/> .\n\n";

while(<>) {
    chop($_);
    my @line = split(/::/,$_);

    my $userQname = "gldu:i" . $line[0];
    my $movieQname = "gldm:i" . $line[1];
    my $rating =  $line[2];

    my ($sec, $min, $hour, $day,$month,$year) = (localtime($line[3]))[0,1,2,3,4,5]; 
    $year += 1900;
    $month = sprintf("%2d",$month + 1);  # because of 0-based  addressing
    $day = sprintf("%2d",$day);
    # Not bothering with time of day information. 
    my $ISODate = "$year-$month-$day"; 
    $ISODate =~ s/ /0/g;
    # Group values with a blank node.
    print "[\n";
    print "  a schema:Review ;\n";
    print "  schema:author $userQname ;\n";
    print "  schema:about $movieQname ;\n";
    print "  schema:reviewRating $rating ;\n";
    print "  dcterms:date \"$ISODate\" \n";
    print "] .\n";
}


