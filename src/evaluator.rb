require_relative "ast"

module JSRuby
  class Evaluator
    def initialize
      @env = {}
    end

    def eval(node)
      case node
      when Number
        node.value
      when StringLiteral
        node.value
      when Var
        @env[node.name]
      when Assign
        @env[node.name] = eval(node.value)
      when BinOp
        eval(node.left).send(node.op, eval(node.right))
      when Call
        if node.func == "print"
          puts eval(node.args.first)
          nil
        else
          raise "Unknown function: #{node.func}"
        end
      else
        raise "Unknown AST: #{node.inspect}"
      end
    end
  end
end
