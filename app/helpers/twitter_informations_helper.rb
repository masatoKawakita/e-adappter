module TwitterInformationsHelper
  def infoColumns(user)
    return {'フォロワー数': user.twitter_information.followers_count,
            'フォロー数': user.twitter_information.followeds_count,
            'お気に入り数': user.twitter_information.favorites_count,
            '総ツイート数': user.twitter_information.tweets_count,
            'アカウント開設日': simple_time(user.twitter_information.account_created_at)
           }
  end

  def tweetDetails(user)
    devideNum = setDevideNum(user).to_f
    return {'リツイートされた回数': user.twitter_information.retweeted_count,
            '平均リツイート数（回/ツイート）': (user.twitter_information.retweeted_count / devideNum).round(3),
            'いいねされた回数': user.twitter_information.liked_count,
            '平均いいね数（回/ツイート）': (user.twitter_information.liked_count / devideNum).round(3),
           }
  end

  def setDevideNum(user)
    tweetsCount = user.twitter_information.tweets_count
    return devideNum = tweetsCount >= 200 ? 200 : tweetsCount
  end
end
