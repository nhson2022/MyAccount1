class PagesController < ApplicationController
  def home
    @articles = Article.all
  end

  def info
  end
end
