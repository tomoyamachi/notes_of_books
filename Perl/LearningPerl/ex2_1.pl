$line = <STDIN>;
chomp($line);
if ($line eq "\n") {
    print "that was just a blank line!!\n";
} else {
    print "that line of input was: $line";
}
