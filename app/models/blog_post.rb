class BlogPost < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged
  
    has_rich_text :content
    has_one_attached :main_image
  
    has_many :blog_post_tags
    has_many :tags, through: :blog_post_tags
  
    validates :status, inclusion: { in: %w[public private] }
  
    # If you have any logic that might change the title or a default title is set here,
    # make sure it's done before FriendlyId generates the slug.
    before_validation :set_default_title, on: :create
  
    def should_generate_new_friendly_id?
      title_changed? || slug.blank?
    end
  
    private
  
    def set_default_title
      if self.title.blank?
        self.title = "Default Title #{BlogPost.maximum(:id).next}"
      end
    end
  end
  