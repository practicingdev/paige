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
          table_settings = {}
          table_settings.update(:column_widths => settings["column_widths"]) if settings["column_widths"]

          @generator.table(settings["key"] ? params[settings["key"]] : settings["data"], table_settings) do
            (settings["column_settings"] || []).each do |index, column_settings|
              (column_settings["style"] || {}).each do |k,v|
                case k
                when "align"
                  column(index).style(:align => v.to_sym)
                when "font_style"
                  column(index).style(:font_style => v.to_sym)
                end
              end
            end

            (settings["row_settings"] || []).each do |index, row_settings|
              (row_settings["style"] || {}).each do |k,v|
                case k
                when "align"
                  row(index).style(:align => v.to_sym)
                when "font_style"
                  row(index).style(:font_style => v.to_sym)
                end
              end
            end

            (settings["cells_settings"]&.[]("style") || {}).each do |k,v|
              case k
              when "padding"
                cells.style(:padding => v)
              end
            end
          end
        end
      end
    end
  end
end
