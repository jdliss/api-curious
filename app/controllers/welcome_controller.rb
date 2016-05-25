class WelcomeController < ApplicationController
  def home
  end

  def generate_headline
    @headline = Article.generate_headline

    respond_to do |format|
      format.js
    end
  end

  def generate_abstract
    @abstract = Article.generate_abstract

    respond_to do |format|
      format.js
    end
  end
end
