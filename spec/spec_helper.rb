require 'embeddable'
require 'rspec/its'

class Dummy
  include Embeddable

  embeddable :video, from: :video_url
  embeddable :super_video, from: :another_url

  attr_accessor :video_url, :another_url
end
