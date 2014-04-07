require 'spec_helper'

describe Embeddable do
  subject { Dummy.new }

  class Dummy
    include Embeddable

    embeddable :video, from: :video_url

    attr_accessor :video_url
  end

  describe '.embeddable' do
    it 'requires a source property' do
      expect do
        Dummy.embeddable :video
      end.to raise_error KeyError
    end
  end

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

  describe 'unsupported scenarios' do

    context 'unknown service' do
      before { subject.video_url = 'http://foobar.com' }

      its(:video_type) { should be_nil }
      its(:video_id)   { should be_nil }
      it { should_not be_video_on_youtube }
    end

    context 'empty property value' do
      before { subject.video_url = nil }

      its(:video_type) { should be_nil }
      its(:video_id)   { should be_nil }
      it { should_not be_video_on_youtube }
    end

  end

end
