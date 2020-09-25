# Permalink

[![Code Climate](https://codeclimate.com/github/fnando/permalink.svg)](https://codeclimate.com/github/fnando/permalink)
[![Build Status](https://travis-ci.org/fnando/permalink.svg)](https://travis-ci.org/fnando/permalink)
[![Gem](https://img.shields.io/gem/v/permalink.svg)](https://rubygems.org/gems/permalink)
[![Gem](https://img.shields.io/gem/dt/permalink.svg)](https://rubygems.org/gems/permalink)

## Installation

    gem install permalink

## Usage

Add the method call `permalink` to your model. Your model should have a
`permalink` attribute.

```ruby
class Page < ActiveRecord::Base
  permalink :title
end
```

You can specify the permalink field:

```ruby
class page < ActiveRecord::Base
  permalink :title, to: "title_permalink"
end
```

If you don't want to use `permalink`, you can call
`Permalink.generate("some text")` string method and manage the permalink process
by yourself.

Permalinks are not unique by default. `permalink` overrides `to_param` as
following:

```ruby
def to_param
  "#{id}-#{permalink}"
end
```

You can define the `to_param` format:

```ruby
class Page < ActiveRecord::Base
  permalink :title, to_param: %w(id permalink page)
end
```

The above settings will generate something link `100-some-title-page`. By
overriding `to_param` method you don't have to change a thing on your app
routes.

If you want to generate unique permalink, use the `:unique` option:

```ruby
class Page < ActiveRecord::Base
  permalink :title, unique: true, to_param: "permalink"
end
```

The permalink can be tied to a given scope. Let's say you want to have unique
permalinks by user. Just set the `:scope` option.

```ruby
class Page < ActiveRecord::Base
  belongs_to :user
  permalink :title, unique: true, scope: "user_id"
end

user = User.first
another_user = User.last

page = user.pages.create(title: 'Hello')
page.permalink #=> hello

another_page = another_user.pages.create(title: 'Hello')
another_page.permalink #=> hello
```

The permalink is generated using `ActiveSupport::Multibyte::Chars` class; this
means that characters will properly replaced from `áéíó` to `aeio`, for
instance.

The permalink is created when `before_validation` callback is evaluated. This
plugin also tries to generate a permalink when `before_save` callback is
evaluated and the instance has no permalink set.

You can force the permalink generation by setting the `:force` option.

```ruby
class Page < ActiveRecord::Base
  permalink :title, force: true
end
```

## License

Copyright (c) 2011-2015 Nando Vieira, released under the MIT license

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
