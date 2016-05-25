class Article < ActiveRecord::Base
  validates :title, uniqueness: true

  def self.populate
    service = ArticleService.new
    service.populate_database
  end

  def self.markovify_headlines
    titles = pluck(:title)
    markov = MarkyMarkov::Dictionary.new('headlines_dictionary')
    titles.each do |title|
      markov.parse_string(title)
    end
    markov.save_dictionary!
  end

  def self.generate_headline
    markov = MarkyMarkov::Dictionary.new('headlines_dictionary')
    headline = markov.generate_n_words(rand(5..10)).delete(".")
    headline = clean_headline(headline)
  end

  def self.clean_headline(headline)
    headline = clean_ending(headline)
    if headline == "" || headline.nil?
      headline = generate_headline
    end
    headline = remove_ending_punctuation(headline)
    headline + "." unless headline.split.last.include?('?')
  end

  def self.clean_ending(headline)
    bad_words = ["the", "at", "in", "or", "of", "a", "it", "its", "it's", "on", "with", "is", "has", "and", "to", "for", "as"]
    while bad_words.include?(headline.split.last.downcase)
      headline = headline.split
      headline.pop
      headline = headline.join(' ')
    end
    headline
  end

  def self.remove_ending_punctuation(headline)
    headline = headline.chars
    headline.pop if [',',':'].include?(headline.last)
    headline.join
  end

  def self.generate_abstract
    markov = MarkyMarkov::Dictionary.new('abstract_dictionary')
    abstract = markov.generate_n_sentences(rand(3..6))
  end

  def self.markovify_abstractions
    abstractions = pluck(:abstract)
    markov = MarkyMarkov::Dictionary.new('abstract_dictionary', 3)
    abstractions.each do |abstract|
      markov.parse_string(abstract)
    end
    markov.save_dictionary!
  end
end
