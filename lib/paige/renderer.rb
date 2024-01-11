module Paige
  class Renderer
    def initialize(generator, template)
      @generator = generator
      @template = template
    end

    def render(params)
      @template.each do |command, settings|
        case command
        when "text"
          settings.kind_of?(Array) 
          text_settings = {}
          text_settings.update(:style => settings["style"].to_sym) if settings["style"]

          if settings["fragments"]
            body = settings["fragments"].map { |e| e["body"] || params[e["key"]] }.join
          else
            body = settings["body"] || params[settings["key"]]
          end

          @generator.text(body, text_settings)
        when "move_down"
          @generator.move_down(settings)
        when "table"
          @generator.table([["A","B","C"],["1","2","3"]])
        end
      end
    end
  end
end