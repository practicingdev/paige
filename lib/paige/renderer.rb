module Paige
  class Renderer
    def initialize(generator, template)
      @generator = generator
      @template = template
    end

    def render(params)
      render_commands(@template, params)
    end

    def render_commands(commands, params)
      commands.each do |command, settings|
        case command
        when "for ->"
          params[settings["key"]].each do |e|
            render_commands(settings["contents"], e)
          end
        when "span"
          span_opts = {}
          if settings["position"]
            span_opts[:position] = settings["position"].to_sym
          end

          @generator.span(settings["width"] || settings["proportion"] * @generator.bounds.width, span_opts) { render_commands(settings["contents"], params) } 
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

          case
          when settings["column_widths"]
            table_settings.update(:column_widths => settings["column_widths"])
          when settings["column_proportions"]
            table_settings.update(:column_widths => settings["column_proportions"].map { |e| e * @generator.bounds.width })
          end

          table_settings.update(:width => @generator.bounds.width) if settings["full_width"]

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

              case column_settings["format"]
              when "number"
                column(index).style(:align => :right)
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
              when "padding", "borders"
                cells.style(k.to_sym => v)
              end
            end
          end
        end
      end
    end
  end
end
