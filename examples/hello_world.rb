require_relative "../lib/paige"
require "prawn"

pdf = Prawn::Document.new

template = [["text", {"key" => "greeting"}]]

Paige::Document.render(pdf, template, "greeting" => "Hello World!")

pdf.render_file("hello.pdf")