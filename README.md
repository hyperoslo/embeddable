# Embeddable

[![Code Climate](https://codeclimate.com/github/hyperoslo/embeddable.png)](https://codeclimate.com/github/hyperoslo/embeddable)
[![Build Status](https://travis-ci.org/hyperoslo/embeddable.png)](https://travis-ci.org/hyperoslo/embeddable)

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
