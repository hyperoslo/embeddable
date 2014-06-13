require 'embeddable/view_helpers'

module Embeddable
  class Railtie < Rails::Railtie
    initializer "embeddable.view_helpers" do
      ActionView::Base.send :include, Embeddable::ViewHelpers
    end

    initializer 'embeddable.add_view_paths', :after => :add_view_paths do |app|
      ActiveSupport.on_load(:action_controller) do
        append_view_path "#{Gem.loaded_specs['embeddable'].full_gem_path}/views"
      end
    end
  end
end
