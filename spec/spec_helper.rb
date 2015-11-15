ENV['RAILS_ENV'] ||= 'test'

require 'rspec/its'
require 'dummy/config/environment'
require 'rspec/rails'
require 'embeddable'

class DummyModel
  include Embeddable

  embeddable :video, from: :video_url
  embeddable :super_video, from: :another_url

  attr_accessor :video_url, :another_url
end
