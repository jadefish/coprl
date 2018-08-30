require_relative 'mixins/common'
require_relative 'mixins/images'
require_relative 'mixins/icons'
require_relative 'mixins/event'
require_relative 'mixins/attaches'
require_relative 'mixins/dialogs'
require_relative 'mixins/chips'
require_relative 'mixins/snackbars'
require_relative 'mixins/selects'
require_relative 'mixins/text_fields'
require_relative 'mixins/date_time_fields'
require_relative 'mixins/steppers'
require_relative 'mixins/sliders'

module Voom
  module Presenters
    module DSL
      module Components
        module Padding
          def coerce_padding(padding)
            case padding
              when true, :full
                [:top, :right, :bottom, :left]
              when false, :none
                []
              else
                Array(padding)
            end
          end

          def validate_padding(padding_)
            validation_msg = 'Padding must either be true or :full, false or :none, '\
                             'or an array containing zero ore more of the following :top, :right, :bottom, :left!'
            if padding_.respond_to?(:pop)
              raise Errors::ParameterValidation, validation_msg if (padding_ - %i(top right bottom left)).any?
            else
              raise Errors::ParameterValidation, validation_msg unless padding_===true ||
                  padding_===false ||
                  %i(full none).include(padding_)
            end
            padding_
          end

        end
        class Grid < Base
          include Mixins::Attaches
          include Mixins::Dialogs
          include Mixins::Snackbars

          attr_accessor :columns, :color, :padding

          def initialize(color: nil, **attribs_, &block)
            super(type: :grid, **attribs_, &block)
            @columns = []
            @color = h(color)
            padding = attribs.delete(:padding) {nil}
            @padding = validate_padding(coerce_padding(padding)).uniq if padding != nil
            expand!
          end

          def column(size, color: nil, **attribs, &block)
            attribs = size.respond_to?(:keys) ? attribs.merge(size) : attribs.merge(size: size)
            @columns << Column.new(parent: self, color: color,
                                   **attribs, &block)
          end

          private
          include Padding
          class Column < EventBase
            include Mixins::Common
            include Mixins::Images
            include Mixins::Icons
            include Mixins::Attaches
            include Mixins::Dialogs
            include Mixins::Chips
            include Mixins::TextFields
            include Mixins::DateTimeFields
            include Mixins::Selects
            include Mixins::Toggles
            include Mixins::Snackbars
            include Mixins::Steppers
            include Mixins::Sliders

            include Padding

            attr_reader :size, :desktop, :tablet, :phone, :color, :components, :padding

            def initialize(**attribs_, &block)
              super(type: :column, **attribs_, &block)
              @size = attribs.delete(:size) || 1
              @desktop = attribs.delete(:desktop)
              @tablet = attribs.delete(:tablet)
              @phone = attribs.delete(:phone)
              @color = attribs.delete(:color)
              @components = []
              padding = attribs.delete(:padding) {nil}
              @padding = validate_padding(coerce_padding(padding)).uniq if padding != nil
              expand!
            end

          end
        end
      end
    end
  end
end
