module JSRuby
  class Lexer
    Token = Struct.new(:type, :value)

    KEYWORDS = {
      "let" => :LET
    }

    def lex(src)
      tokens = []
      i = 0

      while i < src.length
        c = src[i]

        if c =~ /\s/
          i += 1
          next
        end

        if src[i,3] == "let"
          tokens << Token.new(:LET, "let")
          i += 3
          next
        end

        if c =~ /[a-zA-Z_]/
          start = i
          i += 1 while i < src.length && src[i] =~ /[a-zA-Z0-9_]/
          name = src[start...i]
          tokens << Token.new(:IDENT, name)
          next
        end

        if c =~ /\d/
          start = i
          i += 1 while i < src.length && src[i] =~ /\d/
          tokens << Token.new(:NUMBER, src[start...i].to_i)
          next
        end

        if c == '"'
          i += 1
          start = i
          i += 1 while src[i] != '"'
          tokens << Token.new(:STRING, src[start...i])
          i += 1
          next
        end

        case c
        when "=" then tokens << Token.new(:EQUAL, "=")
        when "+" then tokens << Token.new(:PLUS, "+")
        when "-" then tokens << Token.new(:MINUS, "-")
        when "*" then tokens << Token.new(:STAR, "*")
        when "/" then tokens << Token.new(:SLASH, "/")
        when "(" then tokens << Token.new(:LPAREN, "(")
        when ")" then tokens << Token.new(:RPAREN, ")")
        when ";" then tokens << Token.new(:SEMI, ";")
        end

        i += 1
      end

      tokens << Token.new(:EOF, nil)
      tokens
    end
  end
      end
