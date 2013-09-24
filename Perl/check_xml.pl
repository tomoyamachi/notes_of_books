#!/usr/bin/perl -w
use strict;
use XML::Simple;
use Data::Dumper;
use URI::Escape;
use XML::LibXML;


my $parser  = XML::LibXML->new();
my $dom     = $parser->parse_file("stand.ssae");

our %layer_hash = ("effect2",110,
                  "shoulderbag",200
);

for my $node ($dom->findnodes('//animeList/anime/partAnimes/partAnime')){

    # レイヤ名の確認
    my $node_layer_name = $node->findvalue('partName');
    foreach my $replace_layer_name (sort keys %layer_hash) {
        if ($node_layer_name eq $replace_layer_name) {
            # 配列からとってくるレイヤ名と、xmlからパースしたレイヤ名が等しいときの処理
            my $replace_layer_priority = $layer_hash{$replace_layer_name};
            for my $node_attribute ($node->findnodes('attributes')) {
                for my $node_priority ( $node_attribute->findnodes('attribute[@tag = "PRIO"]') ) {
                    my $text = $node_priority->toString();
                    $text =~ s:<attribute tag="PRIO">::;
                    $text =~ s:</attribute>::;
                    $text =~ s:<value>(.*)</value>:<value>${replace_layer_priority}</value>:;
                    print $text."\n";
                    $node_priority->removeChildNodes();
                    $node_priority->appendText($text);

                    print Dumper($node_priority->toString()) . "\n";


                    last;

                }
            }

            last;
        }
    }


    #$text =~ s/.../.../;
    #$node->setData($text);
}

#                    print Dumper($node_priority->toString()) . "\n";
#print $dom->toString();
