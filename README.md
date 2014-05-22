# Embeddable

[![Gem Version](https://img.shields.io/gem/v/embeddable.svg)](https://rubygems.org/gems/embeddable)
[![Build Status](https://img.shields.io/travis/hyperoslo/embeddable.svg)](https://travis-ci.org/hyperoslo/embeddable)
[![Dependency Status](https://img.shields.io/gemnasium/hyperoslo/embeddable.svg)](https://gemnasium.com/hyperoslo/embeddable)
[![Code Climate](https://img.shields.io/codeclimate/github/hyperoslo/embeddable.svg)](https://codeclimate.com/github/hyperoslo/embeddable)
[![Coverage Status](https://img.shields.io/coveralls/hyperoslo/embeddable.svg)](https://coveralls.io/r/hyperoslo/embeddable)

Embeddable makes it easier to embed videos.

## Installation

Add this line to your application's Gemfile:

    gem 'embeddable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install embeddable

## Usage

```ruby
# app/models/post.rb
class Post < ActiveRecord::Base
  include Embeddable

  embeddable :video, from: :video_url
end

# ...
post = Post.new video_url: 'http://www.youtube.com/watch?v=bEvNRmPzq9s'

post.video_on_youtube? # => true
post.video_id          # => 'bEvNRmPzq9s'
```

### Brightcove
If you want to support brightcove, you'll need to add
your own brightcove player by overriding the brightcove partial.

1. Create a partial in your project here: `app/views/embeddable/partials/_brightcove.html.erb`
2. Add your brightcove player code(see example below)
3. Remember to add the following parameters(included in the example below): `id`, `width`, `height`

```html
<div class="BCLcontainingBlock">
  <div class="BCLvideoWrapper">
    <div style="display:none"></div>
    <script type="text/javascript" src="https://sadmin.brightcove.com/js/BrightcoveExperiences.js"></script>

    <object id="brightcove-<%= id %>" class="BrightcoveExperience">
    <param name="secureConnections" value="true" />
    <param name="bgcolor" value="#FFFFFF" />
    <param name="width" value="<%= width %>" />
    <param name="height" value="<%= height %>" />
    <param name="playerID" value="Your player id" />
    <param name="playerKey" value="Your player key" />
    <param name="isVid" value="true" />
    <param name="isUI" value="true" />
    <param name="dynamicStreaming" value="true" />
    <param name="wmode" value="transparent" />

    <param name="@videoPlayer" value="<%= id %>" />

    <param name="includeAPI" value="true" />
    <param name="templateReadyHandler" value="onTemplateReady" />
    </object>

    <script type="text/javascript">brightcove.createExperiences();</script>

  </div>
</div>
```

If you used this example, you must remember to add your own `playerId` and `playerKey`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

Hyper made this. We're a digital communications agency with a passion for good code,
and if you're using this library we probably want to hire you.


## License

Embeddable is available under the MIT license. See the LICENSE file for more info.
