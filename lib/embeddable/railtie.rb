require 'embeddable/view_helpers'

module Embeddable
  class Railtie < Rails::Railtie
    initializer "embeddable.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end
