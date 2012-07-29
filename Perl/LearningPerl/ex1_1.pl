print "Hello,World!!\n";

@lines = `perldoc -u -f atan2`; #外部コマンドを実行
foreach (@lines) {
    s/\w<([^>]+)>/\U$1/g;       # <>にかこまれた単語をupcaseに。
    print;
}
