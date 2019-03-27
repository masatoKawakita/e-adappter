module UsersHelper
  def changeFavoritesToAds(favorites)
    advertisements = []
    favorites.each do |favorite|
      advertisements << favorite.advertisement
    end
    advertisements
  end
end
