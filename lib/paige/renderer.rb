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
          @generator.text(params[settings["key"]])
        end
      end
    end
  end
end