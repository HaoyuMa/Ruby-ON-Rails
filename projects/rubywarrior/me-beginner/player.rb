class Player
 
  def play_turn(warrior)
 
    @max_health = 20
    if @health == nil then @health = @max_health end
 
    is_taking_damage?(warrior)
    actions(warrior)
    record_health(warrior)
 
  end
 
  def is_taking_damage?(warrior)
    #checks current health vs previous health to see if we are being attacked
    @under_attack = @health > warrior.health
  end
 
  def actions(warrior) 
  #potential actions the warrior can take to respond to situations
    if warrior.feel(:backward).empty? == true and @rescue_count != 1
      warrior.walk!(:backward)
    elsif warrior.feel(:backward).empty? == false
      warrior.rescue!(:backward)
      @rescue_count = 1
    else
      if @under_attack == true and warrior.feel.empty? == true
        warrior.walk!
      elsif @under_attack == true and warrior.feel.empty? == false
        if warrior.feel.captive?
          warrior.rescue!
        else
          warrior.attack!
        end
      elsif @under_attack == false and warrior.feel.empty? == true and warrior.health == @max_health
        warrior.walk!
      elsif @under_attack == false and warrior.feel.empty? == false and warrior.health == @max_health
        if warrior.feel.captive?
          warrior.rescue!
        else
          warrior.attack!
        end
      elsif @under_attack == false and warrior.health < @max_health
        warrior.rest!
      end
    end
  end
 
  def record_health(warrior)
  #recurds current health, where @health is equivilent to previous health
    @health = warrior.health
  end
 
end