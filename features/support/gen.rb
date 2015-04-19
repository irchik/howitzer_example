module Gen

  def article(params={})
    prefix = serial
    default = {
        title: gen_article_title(prefix),
        text: gen_article_text(prefix),
    }
    Article.new(default.merge(params))
  end

  def gen_article_title(serial=nil)
    gen_entity('article_title', serial)
  end

  def gen_article_text(serial=nil)
    gen_entity('article_text', serial*7)
  end

  class Article < Object
    attr_reader :title, :text
    def initialize(params={})
      @title = params.delete(:title)
      @text = params.delete(:text)
    end
  end

  def given_article_by_number(num)
    data = DataStorage.extract('article', num.to_i)
    unless data
      data = Gen::article
      DataStorage.store('article', num.to_i, data)
    end
    data
  end

end
