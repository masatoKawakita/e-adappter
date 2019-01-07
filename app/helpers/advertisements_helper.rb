module AdvertisementsHelper
  def category_list
    return ["ゲーム", "ビジネス", "くらし", "便利ツール", "音楽", "画像・動画",
            "スポーツ", "美容・健康", "学校・教育", "お金", "レジャー・アウトドア",
            "エンタメ", "グルメ", "まとめサイト", "その他"]
  end

  def target_sex_list
    return ["男性向け", "女性向け", "男女問わず"]
  end

  def target_age_list
    return ["10代〜", "20代〜", "30代〜", "40代〜"]
  end

  def request_follower_list
    return ["〜500人", "501〜1,000人", "1,001〜2,000人", "2,001〜3,000人",
            "3,001〜5,000人","5,001〜10,000人", "10,001〜50,000人",
            "50,001〜100,000人", "100,000人〜"]
  end

  def ajax_redirect_to(redirect_uri)
    { js: "window.location.replace('#{redirect_uri}');" }
  end
end
