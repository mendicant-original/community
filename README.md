![Community Logo](https://github.com/mendicant-university/community/raw/master/doc/community.png)

A community based site for [Mendicant University](http://mendicantuniversity.org) hosted at
[community.mendicantuniversity.org](http://community.mendicantuniversity.org).

For more information about the site, check out its
[about page](http://community.mendicantuniversity.org/about).

## Installation

Community is a Ruby on Rails 3.1 application which runs on Ruby 1.9.2+ and
[PostgreSQL](http://www.postgresql.org) databases. Other databases like MySQL
or SQLite are not officially supported.

### Setting Up a Development Copy: Step by Step

To install a development version of Community, follow these steps:

1. Fork our GitHub repository: <http://github.com/mendicant-university/community>
2. Clone the fork to your computer
3. If you don't already have bundler installed, get it by running `gem install bundler`
4. Run `bundle install` to install all of the project's dependencies
5. Finally, run `rake setup` to create the required config files, create the database, and seed it with data

To make things even easier, you can copy and paste this into your terminal once you've got the project cloned to your computer

```bash
gem install bundler
bundle install
bundle exec rake setup
```

## Contributing

Features and bugs are tracked through [Github Issues](https://github.com/mendicant-university/community/issues).

Contributors retain copyright to their work but must agree to release their
contributions under the [Affero GPL version 3](http://www.gnu.org/licenses/agpl.html)

If you would like to help with developing Community, just file a ticket in our
[issue tracker](https://github.com/mendicant-university/community/issues)
and we will find something to keep you busy.

### Submitting a Pull Request

1. If a ticket doesn't exist for your bug or feature, create one on GitHub.
    - **NOTE:** Don't be afraid to get feedback on your idea before you begin development work. In fact it is encouraged!
2. Fork the project.
3. Create a topic branch.
4. Implement your feature or bug fix.
5. Add documentation for your feature or bug fix.
6. Add tests for your feature or bug fix.
7. Run `rake test`. If your changes are not 100% covered, go back to step 6.
8. If your change affects something in this README, please update it
9. Commit and push your changes.
10. Submit a pull request.

### Contributors

Jordan Byron // [jordanbyron.com](http://jordanbyron.com) <br/>
Gregory Brown // [majesticseacreature.com](http://majesticseacreature.com/)

[Full List](https://github.com/mendicant-university/community/contributors)

## License

Community is released under the [Affero GPL version 3](http://www.gnu.org/licenses/agpl.html).

If you wish to contribute to Community, you will retain your own copyright but must agree to license your code under the same terms as the project itself.

------

Community - a [Mendicant University](http://mendicantuniversity.org) project