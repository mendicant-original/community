require 'twitter'

namespace :twitter do
  desc 'Post articles to twitter'
  task :post => :environment do
    begin
      twitter_config = YAML.load_file(File.join(Rails.root, 'config', 'twitter.yml'))
    rescue Errno::ENOENT
      puts "config/twitter.yml file doesn't exist!"
    end

    Twitter.configure do |config|
      config.consumer_key       = twitter_config['consumer_key']
      config.consumer_secret    = twitter_config['consumer_secret']
      config.oauth_token        = twitter_config['oauth_token']
      config.oauth_token_secret = twitter_config['oauth_token_secret']
    end

    articles = Article.where(:posted_to_twitter => false).public_only
    articles = ArticleDecorator.decorate(articles)

    articles.each do |article|
      Twitter.update(article.twitter)
      article.update_attribute(:posted_to_twitter, true)
    end
  end
end