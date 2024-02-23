class BlogPostsController < ApplicationController

    before_action :authorize_admin, except: [:index, :show]

    def new
        @blog_post = BlogPost.new
      end
      
      def create
        @blog_post = BlogPost.new(blog_post_params)
        @blog_post.publish_date ||= Time.current
        handle_tags(@blog_post)
        if @blog_post.save
          redirect_to @blog_post, notice: 'Blog post was successfully created.'
        else
          render :new
        end
      end

      def show
        @blog_post = BlogPost.find(params[:id])
      end

      def edit
        @blog_post = BlogPost.find(params[:id])
      end

      def update
        @blog_post = BlogPost.find(params[:id])
        logger.debug "Params: #{blog_post_params.inspect}"
        if @blog_post.update(blog_post_params)
          logger.debug "Updated publish_date: #{@blog_post.publish_date}"
          redirect_to @blog_post, notice: 'Blog post was successfully updated.'
        else
          render :edit
        end
      end
      
      private
      
      def blog_post_params
        params.require(:blog_post).permit(:title, :content, :main_image, :status, :excerpt, :publish_date, tag_ids: [])
      end
    
      def handle_tags(blog_post)
        if params[:new_tag_name].present?
          new_tag = Tag.find_or_create_by(name: params[:new_tag_name])
          blog_post.tags << new_tag unless blog_post.tags.include?(new_tag)
        end
        blog_post.tag_ids += params[:blog_post][:tag_ids].reject(&:blank?) if params[:blog_post][:tag_ids]
      end
      
    

      
end
