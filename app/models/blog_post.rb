class BlogPost < ApplicationRecord
    has_rich_text :content
    has_one_attached :main_image

    has_many :blog_post_tags
    has_many :tags, through: :blog_post_tags
    validates :status, inclusion: { in: %w[public private] }
end
