require "json"

module Paige
  class Document
    def self.render(generator, template, params)
      Paige::Renderer.new(generator, template).render(params)
    end

    def self.render_from_json(generator, template_filename, params_filename)
      Paige::Renderer.new(generator, JSON.load_file(template_filename))
                     .render(JSON.load_file(params_filename))
    end
  end
end