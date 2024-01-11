
require_relative "../lib/paige"
require "prawn"
require "prawn/table"

pdf = Prawn::Document.new

Paige::Document.render_from_json(pdf, "data/invoice/template.json", "data/invoice/params.json")

pdf.render_file("invoice.pdf")