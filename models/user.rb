class User < ActiveRecord::Base
	has_many :followees, through: :followrelationships, class_name: "User"
	has_many :followers, through: :followrelationships, class_name: "User"
	has_many :followrelationships
end