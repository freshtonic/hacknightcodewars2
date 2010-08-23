class Tweet
  include Ripple::Document

  property :coordinates, String
  property :favorited, Boolean
  property :created_at, String
  property :truncated, Boolean
  property :entities, Hash
  property :text, String
  property :contributors, Array
  property :tweet_id, Fixnum
  property :retweet_count, Fixnum
  property :geo, String
  property :retweeted, Boolean
  property :retweeted_status, String
  property :in_reply_to_user_id, Fixnum
  property :in_reply_to_screen_name, String
  property :user, Hash
  property :place, String
  property :source, String
  property :in_reply_to_status_id, String

  def self.make(hash)
    tweet = Tweet.new
    hash.each_pair do |key,value|
      key = 'tweet_id' if key == 'id' # avoids warning messages about using 'id'
      tweet.send "#{key}=".to_sym, value
    end
    tweet
  end
end
