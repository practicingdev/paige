
require_relative "../lib/paige"
require "prawn"
require "prawn/table"

pdf = Prawn::Document.new

Paige::Document.render_from_json(pdf, "data/toc/template.json", "data/toc/params.json")

pdf.render_file("toc.pdf")