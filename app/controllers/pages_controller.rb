class PagesController < ApplicationController
  def home

    set_meta_tags title: 'Welcome to The Ballot Book',
    site: 'The Ballot Book'
  end
end
