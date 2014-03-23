require 'active_support/all'

module Embeddable::Concerns
  module Embeddable
    extend ActiveSupport::Concern

    SERVICES = {
      youtube: [
        %r{^https?://(?:(?:www|m)\.)?youtube\.com/watch\?v=([^&]+)},
        %r{^https?://(?:(?:www|m)\.)?youtu\.be/([^?]+)}
      ],
      vimeo: [
        %r{^https?://(?:www\.)?vimeo\.com/([^\?]+)},
      ]
    }

    module ClassMethods
      def embeddable(name, options = {})
        source = options.fetch :from

        define_method "#{name}_type" do
          url = send(source)
          return if url.blank?

          SERVICES.map do |service, patterns|
            service if patterns.any? { |pattern| url[pattern] }
          end.compact.first
        end

        define_method "#{name}_id" do
          url = send(source)
          return if url.blank?

          SERVICES.map do |service, patterns|
            patterns.map { |pattern| url[pattern, 1] }
          end.flatten.compact.first
        end

        SERVICES.each do |service, pattern|

          define_method "#{name}_on_#{service}?" do
            send("#{name}_type") == service
          end

        end
      end
    end
  end
end
