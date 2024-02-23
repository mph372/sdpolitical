class AddFieldsToBlogPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :blog_posts, :publish_date, :datetime
    add_column :blog_posts, :status, :string
    add_column :blog_posts, :excerpt, :text
  end
end
