require_relative 'base'
require 'voom/presenters/dsl/namespace'

module Voom
  module Presenters
    module DSL
      module Components
        module Actions
          class Replaces < Base
            include Namespace

            def initialize(**attribs_, &block)
              super(type: :replaces, **attribs_, &block)
            end

            def url
              presenter = _expand_namespace_(options[:presenter], namespace)
              @parent.router.url(render: presenter, command: options[:path], context: params)
            end
          end
        end
      end
    end
  end
end