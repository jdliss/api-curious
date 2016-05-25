class ArticleObj < OpenStruct
  def self.service
    ArticleService.new
  end

  def self.all
    articles_hash = service.articles_hash[:results]
    articles_hash.map { |article| ArticleObj.new(article) }
  end

  def self.titles
    all.map { |article| article[:title] }
  end

  def self.save
    all.map do |article|
      Article.create({
        title: article[:title],
        abstract: article[:abstract],
        url: article[:url],
        section: article[:section],
      })
    end
  end
end
