require 'spec_helper'

describe EmbeddableHelper, type: :helper do
  subject { DummyModel.new }
  before  { subject.video_url = 'http://www.youtube.com/?v=123' }

  describe 'embed_video' do
    context 'specifying embeddable name' do
      it 'should use the name provided' do
        expect(helper).to receive(:render).
                           with('embeddable/partials/youtube',
                                {id: "123", width: "100%", height: "100%"})
        helper.embed_video(subject, '100%', '100%', name: :video)
      end

      it 'should raise error if the provided name is wrong' do
        expect do
          helper.embed_video(subject, '100%', '100%', name: :wrong_name)
        end.to raise_error(RuntimeError)
      end
    end

    context 'not specifying embeddable name' do
      it 'should choose the first embeddable name' do
        expect(helper).to receive(:render_embeddable_partial).
          with(subject, :video, '100%', '100%')
        helper.embed_video(subject, '100%', '100%')
      end
    end
  end
end
