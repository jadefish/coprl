require_relative 'mixins/event'

module Voom
  module Presenters
    module DSL
      module Components
        class Image < Base
          include Mixins::Event

          attr_accessor :image, :height, :width, :selected, :url

          def initialize(**attribs_, &block)
            super(type: :image, context: context,
                  **attribs_, &block)
            @image = attribs.delete(:image)
            @height = attribs.delete(:height)
            @width = attribs.delete(:width)
            @selected = attribs.delete(:selected)
            @url = build_url
            expand!
          end
          
          private
          def build_url
            return nil unless image
            return image if image.start_with?('/') || @image.start_with?('http')
            @parent.router.url(render: image, context: {})
          end

        end
      end
    end
  end
end