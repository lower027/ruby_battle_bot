require 'csv'

character_csv = 'C:\Users\Brittany\Documents\ruby_scripts\wishwing_battlebot\character_datasheet.csv'


#initializing Character class

class Character
  attr_accessor :name, :type, :health, :attack, :defense, :speed, :luck

  def initialize(name:, type:, health:, attack:, defense:, speed:, luck:)
      @name = name
      @type = type
      @health = health
      @attack = attack
      @defense = defense
      @speed = speed
      @luck = luck
  end
end

def character_map(filename)
  @character_hash = {}
  CSV.foreach(filename, headers: true, col_sep: ',') do |row|
    character_data = row.to_h
    character = Character.new(
      character_data['NAME'], character_data['TYPE'],
      character_data['HEALTH'], character_data['ATTACK'], character_data['DEFENSE'],
      character_data['SPEED'], character_data['LUCK']
    )
    @character_hash[character.name] = character
  end
  @character_hash
end

#instancing the character map
p character_map(character_csv)
