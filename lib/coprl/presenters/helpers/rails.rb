if defined?(Rails)
  module Coprl
    module Presenters
      module Helpers
        module Rails
          include ActionView::Helpers::AssetUrlHelper
          include Coprl::Presenters::Helpers::Rails::Currency
          include Coprl::Presenters::Helpers::Rails::ModelTable
          include Coprl::Presenters::Helpers::Rails::Routes
          include Namespace

          def presenters_path(presenter, host: false, **params)
            presenter = _expand_namespace_(presenter, namespace)
            presenter = presenter.gsub(':', '/')

            path = if defined?(coprl_presenters_rails_engine_url)
              host ? coprl_presenters_rails_engine_url(params, host: router.base_url) :
                       coprl_presenters_rails_engine_path(params)
            else
              host ? coprl_presenters_web_client_app_url(params, host: router.base_url) :
                       coprl_presenters_web_client_app_path(params)
            end

            if path.include?('?')
              path = path.sub('?', "#{presenter}?")
            else
              path = "#{path}/" unless path.end_with?('/')
              # replace last / with the presenter
              path = path.reverse.sub('/', "/#{presenter}".reverse).reverse
            end
            path
          end

          alias presenter_path presenters_path

          def presenters_url(presenter, host: true, **params)
            presenters_path(presenter, host: host, **params)
          end

          alias presenter_url presenters_url

          def method_missing(name, *args)
            # delegating to `::Rails.application` ensures the `#image_url` and
            # `#image_path` view helper methods have access to
            # `Rails::application.config`, allowing them access to properties
            # they use (e.g. `config.action_controller.asset_host`).
            delegates = [
              ::Rails.application,
              Coprl::Presenters::Helpers::Rails::UrlHelper.instance
            ].freeze

            target = nil
            result = nil

            delegates.each do |delegate|
              if delegate.respond_to?(name)
                ::Rails.logger.warn { "match: delegate #{name} to #{delegate}" }
                target = delegate
                result = delegate.send(name, *args)
                break
              end
            end

            return result if target

            super
          end
        end
      end
    end
  end
end
