module RelationshipsHelper
  def findFollowingUser(user, users)
    @following = []
    user.active_relationships.each do |following|
     @following << users.find(following.followed_id)
    end
    return @following
  end
  
  def findFollowedUser(user, users)
    @followed = []
    user.passive_relationships.each do |followed|
     @followed << users.find(followed.follower_id)
    end
    return @followed
  end
end
