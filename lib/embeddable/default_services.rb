require 'embeddable/service'

module Embeddable
  class Youtube < Embeddable::Service
    domain "youtube.com"
    domain "youtu.be"

    def id
      if @uri.host =~ /youtube.com$/
        query_parameter "v"
      elsif @uri.host =~ /youtu.be$/
        match_path %r{/([^\?]+)}
      end
    end
  end

  class Vimeo < Embeddable::Service
    domain "vimeo.com"

    def id
      match_path %r{/([^\?]+)}
    end
  end

  class Dailymotion < Embeddable::Service
    domain "dailymotion.com"

    def id
      match_path %r{/video/([^\?]+)}
    end
  end

  class Veoh < Embeddable::Service
    domain "veoh.com"

    def id
      match_path %r{/watch/([^\?]+)}
    end
  end

  class Liveleak < Embeddable::Service
    domain "liveleak.com"

    def id
      query_parameter "i"
    end

    def render(view, width, height)
      view.link_to @uri, @uri
    end
  end

  # Special case service: matches embedded HTML which contains a vippy URL
  class Vippy < Embeddable::Service
    REGEXP1 = %r{https:\/\/vippy.co\/play\/.+\/([^\?\s]+)"}
    REGEXP2 = %r{https:\/\/vippy.co\/play\/flash\/watch\/([^\?]+)}

    def initialize(source)
      @source = source
    end

    def id
      (REGEXP1.match(@source) or REGEXP2.match(@source)).try(:captures).try(:first)
    end
  end

  # Special case service: matches a number
  class Brightcove < Embeddable::Service
    def initialize(source)
      @source = source
    end

    def id
      %r{^(\d+)$}.match(@source).try(:captures).try(:first)
    end
  end
end
