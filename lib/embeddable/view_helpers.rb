module ViewHelpers
  def embed(embeddable, width, height)
    if embeddable.video_on_youtube?
      content_tag :iframe, nil, width: width, height: height,
        src: "//www.youtube.com/embed/#{embeddable.video_id}",
        allowfullscreen: true, frameborder: 0
    elsif embeddable.video_on_vimeo?
      content_tag :iframe, nil, width: width, height: height,
        src: "//player.vimeo.com/video/#{embeddable.video_id}",
        webkitallowfullscreen: true, mozallowfullscreen: true,
        allowfullscreen: true, frameborder: 0
    elsif embeddable.video_on_dailymotion?
      content_tag :iframe, nil, width: width, height: height,
        src: "//www.dailymotion.com/embed/video/#{embeddable.video_id}",
        webkitallowfullscreen: true, mozallowfullscreen: true,
        allowfullscreen: true, frameborder: 0
    elsif embeddable.video_on_veoh?
      %Q{
        <object width='#{width}' height='#{height}' id='veohFlashPlayer' name='veohFlashPlayer'>
          <param name='movie' value='http://www.veoh.com/swf/webplayer/WebPlayer.swf?version=AFrontend.5.7.0.1446&permalinkId=#{embeddable.video_id}&player=videodetailsembedded&videoAutoPlay=0&id=anonymous'></param>
          <param name='allowFullScreen' value='true'></param>
          <param name='allowscriptaccess' value='always'></param>
          <embed src='http://www.veoh.com/swf/webplayer/WebPlayer.swf?version=AFrontend.5.7.0.1446&permalinkId=#{embeddable.video_id}&player=videodetailsembedded&videoAutoPlay=0&id=anonymous' type='application/x-shockwave-flash' allowscriptaccess='always' allowfullscreen='true' width='#{width}' height='#{height}' id='veohFlashPlayerEmbed' name='veohFlashPlayerEmbed'></embed>
        </object>
      }.html_safe
    elsif embeddable.video_on_vippy?
      %Q{
        <div itemscope itemtype='http://schema.org/VideoObject' class='vippy-video' style='width: #{width}; height: #{height}; position: relative;'>
          <meta itemprop='thumbnailURL' content='https://vippy.co/play/image/#{embeddable.video_id}' />
          <meta itemprop='embedUrl' content='https://vippy.co/play/flash/watch/#{embeddable.video_id}' />
          <meta itemprop='width' content='#{width}' />
          <meta itemprop='height' content='#{height}' />
          <object class='vippy-video-object' type='application/x-shockwave-flash' data='https://vippy.co/play/flash/watch/#{embeddable.video_id}' width='#{width}' height='#{height}'>
            <param name='player' value='https://vippy.co/play/flash/watch/#{embeddable.video_id}' />
            <param name='allowScriptAccess' value='always' />
            <param name='allowFullScreen' value='true' />
            <param name='wmode' value='direct' />
            <param name='movie' value='https://vippy.co/play/flash/watch/#{embeddable.video_id}' />
            <video style='position: absolute; top: 0px; left: 0px;' class='vippy-video-object' width='#{width}' height='#{height}' preload='none' controls='controls' poster='https://vippy.co/play/image/#{embeddable.video_id}'>
              <source src='https://vippy.co/play/mobile/watch/#{embeddable.video_id}' />
            </video>
          </object>
        </div>
      }.html_safe
    elsif embeddable.video_on_liveleak?
      # not supported
      link_to embeddable.url, embeddable.url
    else
      link_to embeddable.url, embeddable.url
    end
  end
end
