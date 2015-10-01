module Embeddable::ViewHelpers
  def embed_video(embeddable, width, height, options = {})
    if options[:name] && !embeddable.respond_to?("#{options[:name]}_id")
      raise "Can't find embeddable name. Did you mean: \"#{embeddable.class.embeddables.last.inspect}\"?"
    end
    name = options[:name] || embeddable.class.embeddables.first
    render_embeddable_partial(embeddable, name, width, height)
  end

  def render_embeddable_partial(embeddable, name, width, height)
    embeddable.send(name).render(self, width, height)
  end
end
