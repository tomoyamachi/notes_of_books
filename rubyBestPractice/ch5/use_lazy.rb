require "lazy"


a = promise {1}
p a+3
p a
