# Free energyの温度依存
Cuの場合
```sh
momentmethod sample_calc/jindo_Cu/ --plot energy
```
![Cu](./image/energy_Cu.png)
![Ag](./image/energy_Ag.png)
![Au](./image/energy_Au.png)

# Phonon-DOS法(Vasp)との比較
```sh
momentmethod sample_calc/jindo_Cu/ --plot medea
```
![medea_Cu](./image/medea_Cu.png)
![medea_Ag](./image/medea_Ag.png)
![medea_Au](./image/medea_Au.png)
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'momentmethod'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install momentmethod

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/momentmethod.
