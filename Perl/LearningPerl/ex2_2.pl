$n = 1;
while ($n < 10) {
    $sum += $n;
    $n += 2;
}
print $sum."\n"; #=> 25

$madonna = <STDIN>;
if ( defined($madonna)) ) {
    print "the input was $madonna";
} else {
    print "no input available\n";
}
