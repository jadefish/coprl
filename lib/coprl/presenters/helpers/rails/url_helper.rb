##
# UrlHelper is a singleton wrapper around the Rails URL helpers module.
#
# When invoked, the Rails URL helper module's `#url_helpers` method creates a
# new anonymous Module. Since COPRL mixes in this module everywhere (i.e. in
# every component), any time a route helper method is called, a new module is
# created. This is a very expensive operation.
#
# Instead of including the Rails module, delegate calls to `UrlHelper.instance`,
# which itself ensures (by virtue of being a Singleton) that the Rails route
# helpers are not constantly recreated. This occurs in the COPRL Rails helper,
# `Coprl::Presenters::Helpers::Rails#method_missing`.
#
# For more context, see this blog post:
# https://travisofthenorth.com/blog/2017/12/27/rails-urlhelpers
module Coprl::Presenters::Helpers::Rails
  class UrlHelper
    include Singleton
    include ::Rails.application.routes.url_helpers
  end
end
