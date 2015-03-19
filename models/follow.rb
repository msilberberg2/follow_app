class Follow < ActiveRecord::Base
	belongs_to :followee, class_name: "User"
	belongs_to :follower, class_name: "User"
	
	#Returns the followers of the given user id
	#Returned as a list of User objects
	def self.return_followers(user_id)
		follower_ids = self.where(followee_id: user_id).pluck(:follower_id)
		followers = []
		follower_ids.each do |id|
			followers.push(User.find(id))
		end
		return followers
	end
	
	#Returns the accounts followed by the person with the given user id
	#Returned as a list of User objects
	def self.return_followees(user_id)
		followee_ids = self.where(follower_id: user_id).pluck(:followee_id)
		followees = []
		followee_ids.each do |id|
			followees.push(User.find(id))
		end
		return followees
	end
	
	#Returns all follow relationships as a pair of user objects in a 2-element list
	def self.return_relationships()
		relationships = []
		self.find_each do |relationship|
			followee = User.find(relationship.followee_id)
			follower = User.find(relationship.follower_id)
			relationships.push([follower, followee])
		end
		return relationships
	end
end

#Add the following code to the User class.
#has_many :follows
#has_many :followees, through: :follows
#has_many :followers, through: :follows