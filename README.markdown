has_permalink
=============

Instalation
-----------

1. Install the plugin with `script/plugin install git://github.com/fnando/has_permalink.git`
2. Install the unicode gem with `sudo gem install unicode`

Usage
-----

Add the method call `has_permalink` to your model. Your model should have a 'permalink' attribute.

    class Page < ActiveRecord::Base
      has_permalink :title
    end

You can specify the permalink field:

    class page < ActiveRecord::Base
      has_permalink :title, :to => :title_permalink
    end

If you don't want to use `has_permalink`, you can call `'some text'.to_permalink` string method.

Permalinks are not unique. `has_permalink` overrides `to_param` as following:

    def to_param
      "#{id}-#{permalink}"
    end

You can define the `to_param` format:

    class Page < ActiveRecord::Base
      has_permalink :title, :to_param => %w(id permalink page)
    end

The above settings will generate something link `100-some-title-page`. By overriding `to_param` method you don't have to change a thing on your app routes. ;)

The permalink is created when `after_validation` callback is evaluated. This plugin also tries
to generate a permalink when `before_save` callback is evaluated and the instance has no permalink set.

Copyright (c) 2008 Nando Vieira, released under the MIT license