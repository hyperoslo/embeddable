module ViewHelpers
  def embed_video(embeddable, width, height)
    name = embeddable.embeddable_name.to_s
    from = embeddable.embeddable_from

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
      link_to embeddable.send(from), embeddable.send(from)
    elsif embeddable.send("#{name}_on_brightcove?")
      render 'embeddable/partials/brightcove', attributes
    else
      link_to embeddable.send(from), embeddable.send(from)
    end
  end
end
