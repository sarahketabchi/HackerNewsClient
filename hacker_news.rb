require 'rest-client'
require 'open-uri'
require 'nokogiri'

class HackerNewsClient
  def initialize
    @page = Nokogiri::HTML(
    RestClient.get("http://news.ycombinator.com/"))
  end

  def get_front_page
    link_tags = @page.css("tr > td.title > a")

    link_tags.each_with_index do |link, link_i|
      story_name = link_i
      title = link.text
      article_href = link.attr('href')
      story_name = Story.new(link_i, title, article_href)
      story_name.show_story
    end
    return nil
  end
end

class Story
  def initialize(item_num, title, article_link)
    @item_num, @title, @article_link = item_num, title, article_link
  end

  def show_story
    puts "#{@item_num}"
    puts "title: #{@title}"
    puts "article_link: #{@article_link}"
  end
end