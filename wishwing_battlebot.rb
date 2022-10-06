require 'csv'

character_csv = 'C:\Users\Brittany\Documents\ruby_scripts\wishwing_battlebot\character_datasheet.csv'

#type matchups


MATCHUPS = {
  fire: {fire: 0.0, earth: 0.5, ice: -0.5, dark: -0.5},
  light: {light: 0.0, dark: 0.5, ice: 0.5},
  dark: {dark: 0.0, light: 0.5, fire: 0.5},
  wind: {wind: 0.0, steel: 0.5, ice: 0.5, earth: -0.5, fire: -0.5},
  ice: {ice: 0.0, fire: 0.5, steel: 0.5, light: -0.5, wind: -0.5},
  earth: {earth: 0.0, ice: 0.5, wind: 0.5, steel: -0.5, fire: -0.5},
  steel: {steel: 0.0, fire: 0.5, earth: 0.5, wind: -0.5, ice: -0.5}
}


#initializing Character class

class Character
  attr_accessor :name, :type, :health, :attack, :defense, :speed, :luck

  def initialize(name, type, health, attack, defense, speed, luck)
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
      character_data['HEALTH'].to_i, character_data['ATTACK'].to_i, character_data['DEFENSE'].to_i,
      character_data['SPEED'].to_i, character_data['LUCK'].to_i
    )
    @character_hash[character.name] = character
  end
  @character_hash
end



#initializing the battle_arena class
class Battle_arena
  attr_accessor :character_1, :character_2

  def initialize(character_1, character_2)
      @character_1 = character_1
      @character_2 = character_2
  end

  #determining attack multiplier based on critical hit chance and type matchups
  def attack_multiplier(attacker, defender)
      multiplier = 1
      if [0.5, 0.05 * (attacker.luck + 1)].min >= rand
        multiplier += 1
        puts "#{attacker.name} lands a critical hit!"
      end
      multiplier += MATCHUPS[defender.type.downcase.to_sym][attacker.type.downcase.to_sym] || 0
      multiplier
  end

  #character turn
  def character_turn(attacker, defender)
      damage_taken = (attacker.attack * attack_multiplier(attacker, defender)) - (defender.defense * 0.15)
      defender.health -= damage_taken.to_i
      puts "#{defender.name} loses #{damage_taken} health!"
  end

  #character defeated message

  def character_defeated(attacker, defender)
    puts "#{attacker.name} has #{attacker.health} HP left! #{defender.name} has 0 HP left!"
    puts "#{defender.name} cannot battle anymore! #{attacker.name} wins!"
  end


  #the actual battle sequence and log
  def battle 
      
      while (@character_1.health > 0 && @character_2.health > 0 )

          puts "#{@character_1.name} has #{@character_1.health} HP left! #{@character_2.name} has #{@character_2.health} HP left! \n"
          if (@character_1.speed > @character_2.speed)
              character_turn(@character_1, @character_2)
              if @character_2.health <= 0
                  character_defeated(@character_1, @character_2)
              end
              character_turn(@character_2, @character_1)
              if @character_1.health <= 0
                character_defeated(@character_2, @character_1)
              end
              
          elsif (@character_2.speed > @character_1.speed)
              character_turn(@character_2, @character_1)
              if @character_1.health <= 0
                character_defeated(@character_2, @character_1)
              end
              character_turn(@character_1, @character_2)
              if @character_2.health <= 0
                character_defeated(@character_1, @character_2)
              end
              
          else 
              x = rand(1..2)
              if (x == 1)
                  character_turn(@character_1, @character_2)
                  if @character_2.health <= 0
                    character_defeated(@character_1, @character_2)
                  end
                  character_turn(@character_2, @character_1)
                  if @character_1.health <= 0
                    character_defeated(@character_2, @character_1)
                  end
                  
              elsif (x == 2)
                  character_turn(@character_2, @character_1)
                  if @character_1.health <= 0
                    character_defeated(@character_2, @character_1)
                  end
                  character_turn(@character_1, @character_2)
                  if @character_2.health <= 0
                    character_defeated(@character_1, @character_2)
                  end
              end
          end
      end 
    end
end


#instancing the character map
p character_map(character_csv)


#inputting stats for character 1

puts "Enter Character 1's name"
character_1 = @character_hash[gets.chomp.gsub(" ", "_").upcase]



#entering stats for character 2

puts "Enter Character 2's name"
character_2 = @character_hash[gets.chomp.gsub(" ", "_").upcase]

battle_log = Battle_arena.new(character_1, character_2)

battle_log.battle








