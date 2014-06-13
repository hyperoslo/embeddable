require 'spec_helper'
require 'embeddable/view_helpers'

describe Embeddable::ViewHelpers do
  subject { Dummy.new }

  class HelperDummy
    include Embeddable::ViewHelpers

    def link_to(*args)
      true
    end
  end

  before do
    @helper = HelperDummy.new
  end

  describe 'embed_video' do
    context 'specifying embeddable name' do
      it 'should use the name provided' do
        expect(@helper).to receive(:link_to)
        @helper.embed_video(subject, '100%', '100%', name: :super_video)
      end

      it 'should raise error if the provided name is wrong' do
        expect do
          @helper.embed_video(subject, '100%', '100%', name: :wrong_name)
        end.to raise_error
      end
    end

    context 'not specifying embeddable name' do
      it 'should choose the first embeddable name' do
        expect(@helper).to receive(:render_embeddable_partial).
          with(subject, :video, :video_url, '100%', '100%')
        @helper.embed_video(subject, '100%', '100%')
      end
    end
  end
end
