module RelationshipsHelper
  def findFollowingUser(user, users)
    @following = []
    user.active_relationships.each do |following|
     @following << users.find(following.followed_id)
    end
    @following
  end

  def findFollowedUser(user, users)
    @followed = []
    user.passive_relationships.each do |followed|
     @followed << users.find(followed.follower_id)
    end
    @followed
  end
end
