require 'active_support/concern'
require 'active_support/core_ext/object/blank'
require 'embeddable/version'
require 'embeddable/railtie' if defined?(Rails)

module Embeddable
  extend ActiveSupport::Concern

  SERVICES = {
    youtube: [
      %r{^https?://(?:(?:www|m)\.)?youtube\.com/watch\?v=([^&]+)},
      %r{^https?://(?:(?:www|m)\.)?youtu\.be/([^?]+)}
    ],
    vimeo: [
      %r{^https?://(?:www\.)?vimeo\.com/([^\?]+)},
    ],
    dailymotion: [
      %r{^https?://(?:www\.)?dailymotion\.com/video/([^\?]+)},
    ],
    veoh: [
      %r{^https?://(?:www\.)?veoh\.com/watch/([^\?]+)},
    ],
    vippy: [
      %r{https:\/\/vippy.co\/play\/.+\/([^\?\s]+)"},
      %r{https:\/\/vippy.co\/play\/flash\/watch\/([^\?]+)}
    ],
    liveleak: [
      %r{^https?://(?:www\.)?liveleak\.com/view\?i=([^\?]+)},
    ],
    brightcove: [
      %r{^(\d+)$}
    ]
  }

  included do
    @embeddables = []
  end

  module ClassMethods
    attr_reader :embeddables

    def embeddable(name, options = {})
      source = options.fetch :from

      define_method "#{name}_type" do
        url = send(source)
        return if url.blank?

        service = SERVICES.find do |service, patterns|
          patterns.any? { |pattern| url[pattern] }
        end

        service && service.first
      end

      define_method "#{name}_id" do
        url = send(source)
        return if url.blank?

        SERVICES.map do |service, patterns|
          patterns.map { |pattern| url[pattern, 1] }
        end.flatten.compact.first
      end

      define_method "#{name}?" do
        send("#{name}_id") ? true : false
      end

      SERVICES.each do |service, pattern|

        define_method "#{name}_on_#{service}?" do
          send("#{name}_type") == service
        end

      end

      define_method "#{name}_source" do
        source
      end

      @embeddables << name
    end
  end
end
