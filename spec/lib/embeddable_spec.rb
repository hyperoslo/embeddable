require 'spec_helper'

describe Embeddable do
  subject { DummyModel.new }

  describe '.embeddable' do
    it 'requires a source property' do
      expect do
        DummyModel.embeddable :video
      end.to raise_error KeyError
    end
  end

  describe 'predicate' do
    context ':video_url is a supported url' do
      it 'should be true' do
        subject.video_url = 'http://youtube.com/watch?v=1&feature=foo'
        expect(subject.video?).to be_truthy
      end
    end

    context ':video_url is an unsupported url' do
      it 'should be false' do
        subject.video_url = 'http://foo.bar'
        expect(subject.video?).to be_falsey
      end
    end
  end

  describe '.video' do
    it 'should return the service' do
      subject.video_url = 'http://youtube.com/watch?v=1&feature=foo'
      expect(subject.video).to be_an(Embeddable::Service)
    end
  end

  describe '.video_source' do
    it 'should return the source of video' do
      expect(subject.video_source).to eql(:video_url)
    end
  end

  describe '.super_video_source' do
    it 'should return the source of super_video' do
      expect(subject.super_video_source).to eql(:another_url)
    end
  end

  context 'multiple embeddable columns' do
    it 'should store an array of names on the class' do
      expect(DummyModel.embeddables).to eql([:video, :super_video])
    end
  end

  describe 'unsupported scenarios' do

    context 'unknown service' do
      before { subject.video_url = 'http://foobar.com' }

      its(:video) { should be_nil }
      its(:video_type) { should be_nil }
      its(:video_id)   { should be_nil }
      it { should_not be_video_on_youtube }
    end

    context 'empty property value' do
      before { subject.video_url = nil }

      its(:video) { should be_nil }
      its(:video_type) { should be_nil }
      its(:video_id)   { should be_nil }
      it { should_not be_video_on_youtube }
    end

  end

end
