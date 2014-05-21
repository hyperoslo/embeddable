module ViewHelpers
  def embed_video(embeddable, width, height)
    attributes = { id: embeddable.video_id, width: width, height: height }

    if embeddable.video_on_youtube?
      render 'embeddable/partials/youtube', attributes
    elsif embeddable.video_on_vimeo?
      render 'embeddable/partials/vimeo', attributes
    elsif embeddable.video_on_dailymotion?
      render 'embeddable/partials/dailymotion', attributes
    elsif embeddable.video_on_veoh?
      render 'embeddable/partials/veoh', attributes
    elsif embeddable.video_on_vippy?
      render 'embeddable/partials/vippy', attributes
    elsif embeddable.video_on_liveleak?
      # not supported
      link_to embeddable.url, embeddable.url
    else
      link_to embeddable.url, embeddable.url
    end
  end
end
