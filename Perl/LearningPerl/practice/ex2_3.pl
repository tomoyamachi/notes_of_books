print "Input string int: ";
chomp($string = <STDIN>);

print "Input repeat count: ";
chomp($repeat_count = <STDIN>);

$print_str = ($string."\n") x $repeat_count;
print $print_str;
