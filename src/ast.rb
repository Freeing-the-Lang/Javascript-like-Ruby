module JSRuby
  class Expr; end

  class Number < Expr
    attr_reader :value
    def initialize(value); @value = value; end
    def inspect; "Number(#{value})"; end
  end

  class StringLiteral < Expr
    attr_reader :value
    def initialize(value); @value = value; end
    def inspect; "String(#{value})"; end
  end

  class Var < Expr
    attr_reader :name
    def initialize(name); @name = name; end
    def inspect; "Var(#{name})"; end
  end

  class Assign < Expr
    attr_reader :name, :value
    def initialize(name, value); @name = name; @value = value; end
    def inspect; "Assign(#{name} = #{value})"; end
  end

  class BinOp < Expr
    attr_reader :left, :op, :right
    def initialize(left, op, right); @left = left; @op = op; @right = right; end
    def inspect; "BinOp(#{left} #{op} #{right})"; end
  end

  class Call < Expr
    attr_reader :func, :args
    def initialize(func, args); @func = func; @args = args; end
    def inspect; "Call(#{func}, #{args})"; end
  end
end
