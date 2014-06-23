module Embeddable::ViewHelpers
  def embed_video(embeddable, width, height, options = {})
    if options[:name] && !embeddable.respond_to?("#{options[:name]}_id")
      raise "Can't find embeddable name. Did you mean: \"#{embeddable.class.embeddables.last.inspect}\"?"
    end
    name = options[:name] || embeddable.class.embeddables.first
    source = embeddable.send("#{name}_source")
    render_embeddable_partial(embeddable, name, source, width, height)
  end

  def render_embeddable_partial(embeddable, name, source, width, height)
    attributes = { id: embeddable.send("#{name}_id"), width: width, height: height }
    if embeddable.send("#{name}_on_youtube?")
      render 'embeddable/partials/youtube', attributes
    elsif embeddable.send("#{name}_on_vimeo?")
      render 'embeddable/partials/vimeo', attributes
    elsif embeddable.send("#{name}_on_dailymotion?")
      render 'embeddable/partials/dailymotion', attributes
    elsif embeddable.send("#{name}_on_veoh?")
      render 'embeddable/partials/veoh', attributes
    elsif embeddable.send("#{name}_on_vippy?")
      render 'embeddable/partials/vippy', attributes
    elsif embeddable.send("#{name}_on_liveleak?")
      # not supported
      link_to embeddable.send(source), embeddable.send(source)
    elsif embeddable.send("#{name}_on_brightcove?")
      render 'embeddable/partials/brightcove', attributes
    else
      link_to embeddable.send(source), embeddable.send(source)
    end
  end
end
