class Like < ApplicationRecord
	belongs_to :user
	belongs_to :post


	scope :top_five, -> { select('post_id, count(post_id) as count').group(:post_id).order('count desc').limit(5) }
end
