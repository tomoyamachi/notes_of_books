# -*- coding: utf-8 -*-
phrases=["Mr. Gregory Browneee", "Mr. Gregory Brown is cool", "Gregory Brown is cool", "Gregory Brown"]

p phrases.grep /Gregory Brown/

p phrases.grep /\AGregory Brown\z/
p phrases.grep /\AGregory Brown\b/
p phrases.grep /\bGregory Brown\b/

tomos=["Tomoya","Tom","Tomo"]
puts "/Tom(oya)?/ で確かめる。"
tomos.each {|t| puts t[/Tom(oya)?/]}
puts "/\bTom(oya)?l\b/ で確かめる。"
tomos.each {|t| puts t[/\bTom(oya)?\b/]}
