require 'nokogiri'
require 'open-uri'

class BoardgamegeekJob < ApplicationJob
  queue_as :default

  def perform(*args)
    html = get_html
    ids = get_ids html
    xml = get_xml ids
    games = get_items xml
    games.each { |game| update_or_create_game game }
  end

  private

  def get_html
    Nokogiri::HTML(open('https://www.boardgamegeek.com/browse/boardgame/page/1'))
  end

  def get_ids html
    html.css('td.collection_thumbnail a').map { |link| link['href'][/(\d+)/] }
  end

  def get_xml ids
    Nokogiri::XML(open('https://www.boardgamegeek.com/xmlapi2/thing?stats=1&id=' + ids.join(',')))
  end

  def get_items xml
    xml.xpath('//items/item')
  end

  def xpath_value item, xpath
    item.xpath(xpath).attribute('value').value
  end

  def xpath_values item, xpath
    item.xpath(xpath).map { |xml| xml.attribute('value').value }
  end

  def update_or_create_game game
    boardgame = Boardgame.find_or_initialize_by(geek_id: game.attribute('id').value)
    boardgame.update_attributes(
      thumbnail: game.xpath('thumbnail').text,
      image: game.xpath('image').text,
      name: xpath_value(game, "name[@type='primary']"),
      year: xpath_value(game, 'yearpublished'),
      min_players: xpath_value(game, 'minplayers'),
      max_players: xpath_value(game, 'maxplayers'),
      play_time: xpath_value(game, 'playingtime'),
      geek_rating: xpath_value(game, 'statistics/ratings/bayesaverage'),
      geek_rank: xpath_value(game, "statistics/ratings/ranks/rank[@name='boardgame']"),
    )
  end
end
