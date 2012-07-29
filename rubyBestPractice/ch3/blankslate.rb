class BlankSlate
  class << self
    def hide(name)
      if instance_methods.include?(name) and name !~ /^(__|instance_eval)/
        @hidden_methods ||= {}
        @hidden_methods[name] = instance_method(name)
        undef_method name
      end
    end

    def find_hidden_method(name)
      @hidden_methods ||= {}
      @hidden_methods[name] || superclass.find_hidden_method(name)
    end

    def reveal(name)
      unbound_method = find_hidden_method(name)
      fail "dont know #{name}" unless unbound_method
      define(name,unbound_method)
    end
  end

  instance_methods.each {|m| hide(m) }
end
class A < BlankSlate;end
a = A.new
p A.instance_methods
class B < BasicObject;end
p B.instance_methods
