# ruuid-mongoid

[![Build Status](https://img.shields.io/travis/hashrabbit/ruuid-mongoid.svg)][travis]

ruuid-mongoid provides BSON types and mixins for handling storage and retrieval
of UUIDs within Mongoid models.

[travis]: https://travis-ci.org/hashrabbit/ruuid-mongoid

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruuid-mongoid'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruuid

## Example Usage

### UUID Primary Key

```ruby
class Student
  include Mongoid::Document
  include RUUID::UUID
end

student = Student.new
# => #<Student _id: dc2533e4-87e4-4eca-a260-46006f34d3ff>
student.id.class
# => RUUID::UUID
```

### UUID Field

```ruby
class ReportCard
  include Mongoid::Document

  field :legacy_id, type: :uuid

  belongs_to :student
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release` to create a git tag for the version, push git commits
and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/hashrabbit/ruuid-mongoid/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
