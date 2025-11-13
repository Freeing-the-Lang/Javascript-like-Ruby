require_relative "lexer"
require_relative "parser"
require_relative "evaluator"

include JSRuby

code = File.read("examples/hello.jrb")

tokens = Lexer.new.lex(code)
puts "[Tokens]"
p tokens

ast = Parser.new(tokens).parse
puts "\n[AST]"
p ast

puts "\n[Result]"
ev = Evaluator.new
ast.each { |stmt| ev.eval(stmt) }
