class Article < ActiveRecord::Base
  validates :title, uniqueness: true

  def self.populate
    service = ArticleService.new
    service.populate_database
  end
end
