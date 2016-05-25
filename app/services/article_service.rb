class ArticleService
  def initialize
    @connection = Faraday.new(url: "http://api.nytimes.com/svc/mostpopular/v2/mostemailed/all-sections/")
    @connection.params["api-key"] = ENV["NY_TIMES_API"]
  end

  def get_articles
    @connection.get("30.json")
  end

  def get_all_articles(i)
    @connection.get("30.json?offset=#{20 * i}")
  end

  def all_articles_hash(num)
    (num/20).times do |i|
      articles = parse(get_all_articles(i))
      store_articles(articles[:results])
    end
  end

  def articles_hash
    parse(get_articles)
  end

  def store_articles(articles)
    articles.map do |article|
      Article.create({
        title: article[:title],
        abstract: article[:abstract],
        url: article[:url],
        section: article[:section],
      })
    end
  end

  def populate_database
    num_results = articles_hash[:num_results]
    all_articles_hash(num_results)
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
