require_relative "ast"

module JSRuby
  class Parser
    def initialize(tokens)
      @tokens = tokens
      @pos = 0
    end

    def peek
      @tokens[@pos]
    end

    def next_token
      @pos += 1
      @tokens[@pos - 1]
    end

    def parse
      statements = []
      while peek.type != :EOF
        statements << parse_stmt
      end
      statements
    end

    def parse_stmt
      if peek.type == :LET
        next_token
        name = next_token.value
        next_token # '='
        value = parse_expr
        next_token if peek.type == :SEMI
        return Assign.new(name, value)
      else
        expr = parse_expr
        next_token if peek.type == :SEMI
        return expr
      end
    end

    def parse_expr
      left = parse_primary

      while [:PLUS, :MINUS].include?(peek.type)
        op = next_token.value
        right = parse_primary
        left = BinOp.new(left, op, right)
      end

      left
    end

    def parse_primary
      case peek.type
      when :NUMBER
        Number.new(next_token.value)
      when :STRING
        StringLiteral.new(next_token.value)
      when :IDENT
        id = next_token.value
        if peek.type == :LPAREN
          next_token
          args = []
          args << parse_expr until peek.type == :RPAREN
          next_token
          return Call.new(id, args)
        end
        Var.new(id)
      else
        raise "Unexpected token: #{peek}"
      end
    end
  end
  end
