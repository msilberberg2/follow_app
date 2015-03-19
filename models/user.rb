class User < ActiveRecord::Base
	has_many :followees, through: :follows, class_name: "User"
	has_many :followers, through: :follows, class_name: "User"
	has_many :follows
end