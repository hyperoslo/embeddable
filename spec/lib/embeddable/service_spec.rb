require 'spec_helper'

class DummyService < Embeddable::Service
  domain "example.com"
end

class DummyService2 < Embeddable::Service
  domain "abc.example.com"
end

describe Embeddable::Service do

  it "should know about the DummyService service" do
    expect(Embeddable::Service.all).to include(DummyService)
  end

  it "should know about the DummyService2 service" do
    expect(Embeddable::Service.all).to include(DummyService2)
  end

  describe "#find_for_uri" do
    subject { Embeddable::Service.find_for_uri URI.parse(uri) }

    context "with a matching domain" do
      let (:uri) { "http://example.com/" }
      it { should be_an_instance_of(DummyService) }
    end

    context "with additional subdomains" do
      let (:uri) { "http://xyz.123.example.com/" }
      it { should be_an_instance_of(DummyService) }
    end

    context "with a more specific domain" do
      let (:uri) { "http://xyz.abc.example.com/" }
      it { should be_an_instance_of(DummyService2) }
    end

    context "with an unknown domains" do
      let (:uri) { "http://xyz.com/" }
      it { should be_falsy }
    end
  end

  describe ".query_parameter" do
    let (:service) { Embeddable::Service.find_for_uri URI.parse(uri) }
    subject { service.query_parameter "x" }

    context "with no querystring" do
      let (:uri) { "http://example.com/" }
      it { should be_falsy }
    end

    context "with one value" do
      let (:uri) { "http://example.com/?x=value" }
      it { should eq("value") }
    end

    context "with two values" do
      let (:uri) { "http://example.com/?x=value1&x=value2" }
      it { should eq("value1") }
    end
  end

  describe ".match_path" do
    let (:service) { Embeddable::Service.find_for_uri URI.parse(uri) }
    subject { service.match_path regexp }

    context "with a matching path" do
      let (:uri) { "http://example.com/path" }
      let (:regexp) { /(path)/ }
      it { should be_truthy }
    end

    context "with a non matching path" do
      let (:uri) { "http://example.com/path" }
      let (:regexp) { /(xyz)/ }
      it { should be_falsy }
    end

    context "with one capture" do
      let (:uri) { "http://example.com/some/path" }
      let (:regexp) { /(path)/ }
      it { should eq("path") }
    end
  end

end
