print "Input radius: ";
chomp($radius = <STDIN>);

if ($radius < 0) {
    $radius = 0;
}
$diameter = $radius * 2;
$pi = 3.14;
$circumference = $diameter * $pi;

print "This circle\'s circumference is ".$circumference.".\n";
