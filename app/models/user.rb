class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy

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


	def likes(post_id)
		# facebook.get_object('966978620053068_971364312947832', :fields => "likes.summary(true)")["likes"]["summary"]["total_count"]
		#full post id for user
		fpost_id = ""
		fpost_id = uid + "_"  + post_id
		begin
			facebook.get_object(fpost_id, :fields => "likes.summary(true)")["likes"]["summary"]["total_count"]
		rescue
			return false
		end
		
	end

	def shares(post_id)
		fspost_id = ""
		fspost_id = uid + "_" + post_id
		begin
			facebook.get_object('/'+fspost_id+'/sharedposts?limit=10000&format=json').size
		rescue
			return false
		end
	end 

	def comments(post_id)
		fcpost_id = ""
		fcpost_id = uid + "_" + post_id
		begin
			facebook.get_object(fcpost_id, :fields => "comments.summary(true)")["comments"]["summary"]["total_count"]
		rescue
			return false
		end
	end
end
