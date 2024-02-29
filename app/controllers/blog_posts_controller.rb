class BlogPostsController < ApplicationController

  before_action :authorize_admin, except: [:index, :show]
  before_action :set_blog_post, only: [:show, :edit, :update]

  def new
    @blog_post = BlogPost.new
  end

  def index
    if params[:tag_name]
      @blog_posts = BlogPost.joins(:tags).where(tags: { name: params[:tag_name] }).order(publish_date: :desc)
    else
      @blog_posts = BlogPost.order(publish_date: :desc).limit(4)
    end
    @recent_blog_posts = BlogPost.order(created_at: :desc).limit(4)
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
    set_meta_tags title: @blog_post.title,
    site: 'The Ballot Book',
    reverse: true,
    description: @blog_post.excerpt,
    keywords: @blog_post.tags.map(&:name).join(', '),
    twitter: {
      card: "summary",
      title: @blog_post.title,
      description: @blog_post.excerpt
    },
    og: {
      title: @blog_post.title,
      description: @blog_post.excerpt,
      type: 'website',
      url: blog_post_url(@blog_post),
      image: @blog_post.main_image.present? ? url_for(@blog_post.main_image) : nil
    }
  end

  def edit
  end

  def update
    handle_tags(@blog_post)
    if params[:blog_post][:remove_main_image] == '1'
      @blog_post.main_image.purge
    end
  
    if @blog_post.update(blog_post_params.except(:remove_main_image))
      redirect_to @blog_post, notice: 'Blog post was successfully updated.'
    else
      render :edit
    end
  end

  private
  
  def set_blog_post
    @blog_post = BlogPost.friendly.find(params[:id])
  end

  def blog_post_params
    params.require(:blog_post).permit(:title, :content, :main_image, :status, :excerpt, :publish_date, :remove_main_image, tag_ids: [])  end

  def handle_tags(blog_post)
    if params[:new_tag_name].present?
      new_tag = Tag.find_or_create_by(name: params[:new_tag_name])
      blog_post.tags << new_tag unless blog_post.tags.include?(new_tag)
    end
    blog_post.tag_ids += params[:blog_post][:tag_ids].reject(&:blank?) if params[:blog_post][:tag_ids]
  end
end
