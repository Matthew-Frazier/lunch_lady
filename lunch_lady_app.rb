require "pry"

class MainDish
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end

class SideDish
  attr_accessor :name, :price
  
  def initialize(name, price)
    @name = name
    @price = price
  end

end

class LunchLady
  attr_accessor :main_dish, :side_dish

  def initialize
    @main_dish = [
      MainDish.new("Pizza", 2.00),
      MainDish.new("Taco", 1.50),
      MainDish.new("Burger", 3.00),
    ]
    @side_dish = [
      SideDish.new("Garlic Bread", 2.00),
      SideDish.new("Rice and Black Beans", 1.00),
      SideDish.new("French Fries", 1.25),
    ]
    @order_item = []
    @order_price = []

    greeting
  end

  def greeting
    puts "Hello Welcome to the Lunch Room"
    puts "I am the Lunch Lady"
    puts "Who are you?"
    print "> "
    @user_name = gets.strip
    puts "What is the total amount you can spend?"
    print "> "
    @user_wallet = gets.to_f
    ordering_main
  end

  def ordering_main
    puts "What would you like for your main dish?"
    @main_dish.each_with_index do |m, i|
      puts "#{i + 1})\n Main Dish: #{m.name}\n Price: $#{m.price}"
    end
    main_choice = gets.strip.to_i - 1
    puts "You chose #{@main_dish[main_choice].name}"
    @order_item << @main_dish[main_choice].name
    @order_price << @main_dish[main_choice].price
    extra_option
  end

def ordering_side
  puts "What would you like for your side dish?"
  @side_dish.each_with_index do |s, i|
      puts "#{i + 1})\n Side Dish: #{s.name}\n Price: $#{s.price}"
    end
    side_choice = gets.strip.to_i - 1
    puts "You chose #{@side_dish[side_choice].name}"
    @order_item << @side_dish[side_choice].name
    @order_price << @side_dish[side_choice].price
    extra_option
  end

  def extra_option
    puts "Add a main, side, or proceed to checkout?"
    puts "1) Add a main dish"
    puts "2) Add a side dish"
    puts "3) Checkout"
    choice = gets.strip.to_i
    case choice
    when 1
      ordering_main
    when 2
      ordering_side
    when 3
      your_order
      your_total
      purchase_option
    else
      puts "Invalid Choice"
      extra_option
    end
  end

  def your_order
    puts "Your current order is:"
    @order_item.each_with_index do |f, i|
      puts "#{i + 1}) #{f}"
    end
  end

  def your_total
    @result = @order_price.inject(0){|sum,x| sum + x}
    puts "Your current total is:"
    puts @result
  end

  def add_order
    puts "Add another main dish, side dish or remove a dish?"
    puts "1) Add main dish"
    puts "2) Add side dish"
    puts "3) Remove item"
    choice = gets.strip.to_i
    case choice
    when 1
      ordering_main
    when 2
      ordering_side
    when 3
      remove_item
    else
      puts "Invalid Choice"
      add_order
    end
  end
  
  def remove_add_item
    puts "Would you like to remove another item?"
    puts "1) Yes"
    puts "2) No"
    choice_2 = gets.strip.to_i
    case choice_2
    when 1
      remove_item
    when 2
      purchase_option
    else
      puts "Invalid Choice"
      remove_item
    end
  end

  def remove_item
    while @order_item.empty?
      puts "You have no items to remove"
      ordering_main
    end
    puts "Pick an item to remove"
    @order_item.each_with_index do |f, i|
      puts "#{i + 1}) #{f}"
    end
    choice = gets.strip.to_i
    if choice > 0 && choice <= @order_item.length
      @order_item.delete_at(choice - 1)
      @order_price.delete_at(choice - 1)
      remove_add_item
    else
      puts "Invalid Choice"
      remove_item
    end
  end
  
  def remove_order
    if @order_item.empty?
      puts "You haven't ordered anything!"
      ordering_main
    else
      @order_price.clear
      @order_item.clear
      puts "Your order has be removed"
      ordering_main
    end
  end
  
  def remove
    puts "Would you like to remove an item or remove your order?"
    puts "1) Remove item"
    puts "2) Remove order"
    choice = gets.strip.to_i
    if choice == 1
      remove_item
    elsif choice == 2
      remove_order
    else
      "Invalid Choice"
      remove
    end
  end
  
  def purchase_option
    puts "Would you like to purchase your meal now?"
    puts "1) Yes"
    puts "2) No"
    choice = gets.strip.to_i
    if choice == 1
      purchase
    elsif choice == 2
      ordering_main
    else
      puts "Invalid Choice"
      purchase_option
    end
  end

  def purchase
    if @result <= @user_wallet
      puts "Your total change is $#{@user_wallet - @result}"
      puts "Enjoy your meal #{@user_name}!!!"
      exit
    else
      puts "Insufficient funds"
      remove
    end
  end
end

binding.pry
LunchLady.new
