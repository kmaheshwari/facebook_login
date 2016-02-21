class User < ActiveRecord::Base

	def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
	    user.provider = auth.provider
	    user.uid = auth.uid
	    user.name = auth.info.name
	    user.oauth_token = auth.credentials.token
	    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
	    user.save!
	  end
	end

	def facebook
		@facebook ||= Koala::Facebook::API.new(oauth_token)
	end

	def friends_count
		facebook.get_connection("me", "friends").size
	end

	def likes
		facebook.get_object("966978620053068_968678173216446", :fields => "likes.summary(true)")["likes"]["summary"]["total_count"]
		# post_kpis = facebook.get_connections(@post, 'insights', metric: 'post_storytellers_by_action_type').first["values"].first["value"]
	end

	def shares
		# facebook.get_object('966978620053068_968678173216446', :fields => "shares")["shares"]
		facebook.get_object('/'+'966978620053068_968678173216446'+'/sharedposts?limit=10000&format=json').size
	end

	def comments
		facebook.get_object('966978620053068_968678173216446', :fields => "comments.summary(true)")["comments"]["summary"]["total_count"]
	end
end
