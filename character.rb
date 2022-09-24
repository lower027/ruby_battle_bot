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
    character = Character.new(name: row['NAME'], type: row['TYPE'], health: row['HEALTH'], attack: row['ATTACK'], defense: row['DEFENSE'], speed: row['SPEED'], luck: row['LUCK'])
    @character_hash[character.name] = character
    puts row['NAME'].class
    puts row['TYPE'].class
  end
  @character_hash
end

#instancing the character map
p character_map(character_csv)