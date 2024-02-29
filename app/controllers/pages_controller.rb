class PagesController < ApplicationController
  def home


    @recent_blog_posts = BlogPost.order('publish_date DESC').limit(5)
    set_meta_tags title: 'Welcome to The Ballot Book',
                  site: 'The Ballot Book',
                  description: 'A comprehensive database of elected officials, districts, and campaign finance for all of San Diego County.' 
  end
end
