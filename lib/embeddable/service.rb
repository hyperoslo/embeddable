module Embeddable
  class Service
    def initialize(uri)
      @uri = uri
    end

    def self.type
      self.name.demodulize.underscore
    end

    # Returns the value of a query parameter. Query keys can occur
    # multiple times in a query string - this method returns the first
    # value.
    def query_parameter(param)
      return nil unless @uri.query
      URI.decode_www_form(@uri.query).assoc(param).try(:at, 1)
    end

    # Match the URI path against a regexp and return the first capture
    def match_path(re)
      re.match(@uri.path).try(:captures).try(:first)
    end

    # Render the embeddable object
    def render(view, width, height)
      attributes = { id: id, width: width, height: height }
      view.render "embeddable/partials/#{self.class.type}", attributes
    end

    # Track all of the subclasses of Service so we can respond to
    # <embeddable>_on_<service>?
    @@services = []

    def self.inherited(subclass)
      @@services << subclass
    end

    def self.all
      @@services
    end

    # A lookup with a URI host as a key and a service as a
    # value. Allows us to O(1) lookup a service.
    @@service_domains = {}

    def self.domain(domain)
      @@service_domains[domain] = self
    end

    # Find the most specific service for a domain. i.e. For a domain
    # xyz.abc.123.com it will try to find a service for
    # xyz.abc.123.com, abc.123.com and 123.com in that order.
    def self.find_for_uri(uri)
      parts = uri.host.split(".")
      for i in 0..(parts.length - 1) do
        host = parts.drop(i).join(".")
        service = @@service_domains[host]
        return service.new uri if service
      end
      nil
    end

    # Find a Service given a source string. The source string is
    # typically a URI, but can include snippets of HTML or IDs in the
    # case of Vippy and Brigtcove
    def self.find(source)
      begin
        find_for_uri URI.parse(source)
      rescue URI::InvalidURIError
        # If the source is not a URL, try to match against some
        # special case services
        [Vippy, Brightcove].each do |service|
          instance = service.new source
          return instance if instance.id
        end
      end
    end
  end
end
