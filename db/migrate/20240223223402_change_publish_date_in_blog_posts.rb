class ChangePublishDateInBlogPosts < ActiveRecord::Migration[6.1]
  def change
    change_column :blog_posts, :publish_date, :date
  end
end
