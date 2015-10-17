require 'spec_helper'

describe 'default services' do
  subject { Dummy.new }

  describe 'Liveleak' do
    context 'with http://liveleak.com/...' do
      before {
        subject.video_url = 'http://www.liveleak.com/view?i=290_1392029603'
      }

      its(:video_type) { should eq :liveleak }
      its(:video_id)   { should eq '290_1392029603' }
    end
  end

  describe 'Dailymotion' do
    context 'with http://dailymotion.com/video/<id>...' do
      before {
        subject.video_url = 'http://www.dailymotion.com/video/xu4q8m'
      }

      its(:video_type) { should eq :dailymotion }
      its(:video_id)   { should eq 'xu4q8m' }
    end

    context 'with http://dailymotion.com/video/<id>_<blargablarga>...' do
      before {
        subject.video_url = 'http://www.dailymotion.com/video/xu4q8m_apprendre-le-deltaplane-a-millau-hang-gliding-in-france-creative-motion_sport'
      }

      its(:video_type) { should eq :dailymotion }
      its(:video_id)   { should eq 'xu4q8m_apprendre-le-deltaplane-a-millau-hang-gliding-in-france-creative-motion_sport' }
    end
  end

  describe 'Veoh' do
    context 'with http://veoh.com/watch/<id>...' do
      before {
        subject.video_url = 'http://www.veoh.com/watch/v36298453QmtnSAza'
      }

      its(:video_type) { should eq :veoh }
      its(:video_id)   { should eq 'v36298453QmtnSAza' }
    end

    context 'with http://veoh.com/watch/<id>/<blargablarga>...' do
      before {
        subject.video_url = 'http://www.veoh.com/watch/v36298453QmtnSAza/CBS-SciTech-News'
      }

      its(:video_type) { should eq :veoh }
      its(:video_id)   { should eq 'v36298453QmtnSAza/CBS-SciTech-News' }
    end
  end

  describe 'Vimeo' do
    context 'with http://vimeo.com/...' do
      before { subject.video_url = 'https://vimeo.com/77949044' }

      its(:video_type) { should eq :vimeo }
      its(:video_id)   { should eq '77949044' }
    end
  end

  describe 'Vippy' do
    context 'with http://liveleak.com/...' do
      before {
        subject.video_url = <<SUCH_EMBED_CODE
<!-- Start Vippy video -->
<div itemscope itemtype="http://schema.org/VideoObject" class="vippy-video" style="width: 640px; height: 360px; position: relative;">
	<meta itemprop="name" content="bademiljo_hurum_v1.mp4" />
	<meta itemprop="duration" content="PT9M38S" />
	<meta itemprop="thumbnailURL" content="https://vippy.co/play/image/pretty-cool-video" />
	<meta itemprop="contentURL" content="http://cdn2.vippy.co/10455/video/out/nice-stuff.mp4" />
	<meta itemprop="embedUrl" content="https://vippy.co/play/flash/watch/pretty-cool-video" />
	<meta itemprop="uploadDate" content="2014-04-30" />
	<meta itemprop="width" content="640" />
	<meta itemprop="height" content="360" />
	<object class="vippy-video-object" type="application/x-shockwave-flash" data="https://vippy.co/play/flash/watch/pretty-cool-video" id="some-id" width="640" height="360">
		<param name="player" value="https://vippy.co/play/flash/watch/pretty-cool-video" />
		<param name="allowScriptAccess" value="always" />
		<param name="allowFullScreen" value="true" />
		<param name="wmode" value="direct" />
		<param name="movie" value="https://vippy.co/play/flash/watch/pretty-cool-video" />
		<video style="position: absolute; top: 0px; left: 0px;" class="vippy-video-object" width="640" height="360" preload="none" controls="controls" poster="https://vippy.co/play/image/pretty-cool-video">
			<source src="https://vippy.co/play/mobile/watch/pretty-cool-video" />
		</video>
	</object>
</div>
<!-- End Vippy video -->
SUCH_EMBED_CODE
      }

      its(:video_type) { should eq :vippy }
      its(:video_id)   { should eq 'pretty-cool-video' }
    end
  end

  describe 'YouTube' do

    context 'with http://youtube.com/watch?v=...' do
      before { subject.video_url = 'http://youtube.com/watch?v=1&feature=foo' }

      its(:video_type) { should eq :youtube }
      its(:video_id)   { should eq '1' }
      it { should be_video_on_youtube }
    end

    context 'with https://youtube.com/watch?v=...' do
      before { subject.video_url = 'https://youtube.com/watch?v=1&feature=foo' }

      its(:video_type) { should eq :youtube }
      its(:video_id)   { should eq '1' }
      it { should be_video_on_youtube }
    end

    context 'with http://www.youtube.com/watch?v=...' do
      before { subject.video_url = 'http://www.youtube.com/watch?v=1&feature=foo' }

      its(:video_type) { should eq :youtube }
      its(:video_id)   { should eq '1' }
      it { should be_video_on_youtube }
    end

    context 'with http://m.youtube.com/watch?v=...' do
      before { subject.video_url = 'http://m.youtube.com/watch?v=1&feature=foo' }

      its(:video_type) { should eq :youtube }
      its(:video_id)   { should eq '1' }
      it { should be_video_on_youtube }
    end

    context 'with http://youtu.be/...' do
      before { subject.video_url = 'http://youtu.be/1' }

      its(:video_type) { should eq :youtube }
      its(:video_id)   { should eq '1' }
      it { should be_video_on_youtube }
    end

    context 'with https://youtu.be/...' do
      before { subject.video_url = 'https://youtu.be/1' }

      its(:video_type) { should eq :youtube }
      its(:video_id)   { should eq '1' }
      it { should be_video_on_youtube }
    end

    context 'with http://www.youtu.be/...' do
      before { subject.video_url = 'http://www.youtu.be/1' }

      its(:video_type) { should eq :youtube }
      its(:video_id)   { should eq '1' }
      it { should be_video_on_youtube }
    end

    context 'with http://m.youtu.be/...' do
      before { subject.video_url = 'http://m.youtu.be/1' }

      its(:video_type) { should eq :youtube }
      its(:video_id)   { should eq '1' }
      it { should be_video_on_youtube }
    end
  end
end
