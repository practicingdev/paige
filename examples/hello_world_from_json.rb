require_relative "../lib/paige"
require "prawn"

pdf = Prawn::Document.new

Paige::Document.render_from_json(pdf, "data/hello_template.json", "data/hello_params.json")

pdf.render_file("hello.pdf")