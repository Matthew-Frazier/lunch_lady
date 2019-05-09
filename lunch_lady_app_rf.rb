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
    puts
    print "Name: > "
    @user_name = gets.strip
    puts
    puts "What is the total amount you can spend?"
    puts
    print "Amount: > $"
    @user_wallet = gets.to_f
    puts
    main_menu
  end

  def main_menu
    puts "____________________________________________"
    puts "Hello #{@user_name}. Please pick an option:"
    puts
    puts "1) Add a main dish"
    puts "2) Add a side dish"
    puts "3) View order and total"
    puts "4) Remove an item"
    puts "5) Proceed to checkout"
    puts "6) Cancle order"
    puts "7) Exit"
    puts "____________________________________________"
    puts 
    choice = gets.strip.to_i
    puts
    puts
    case choice
    when 1 
      puts
      ordering_main
    when 2
      puts
      ordering_side
    when 3
      puts
      your_order
      your_total
      main_menu
    when 4
      puts
      remove_item
    when 5
      puts
      purchase
    when 6
      puts
      remove_order
    when 7 
      exit
    else
      puts "Invalid Choice"
      puts
      main_menu
    end
  end

  def ordering_main
    puts "What main dish would you like?"
    puts
    @main_dish.each_with_index do |m, i|
      puts "#{i + 1})\n Main Dish: #{m.name}\n Price: $#{m.price}"
    end
    puts
    main_choice = gets.strip.to_i - 1
    puts
    puts "You chose #{@main_dish[main_choice].name}"
    puts
    @order_item << @main_dish[main_choice].name
    @order_price << @main_dish[main_choice].price
    main_menu
  end

def ordering_side
  puts "What side dish would you like?"
  puts
  @side_dish.each_with_index do |s, i|
      puts "#{i + 1})\n Side Dish: #{s.name}\n Price: $#{s.price}"
    end
    puts
    side_choice = gets.strip.to_i - 1
    puts
    puts "You chose #{@side_dish[side_choice].name}"
    puts
    @order_item << @side_dish[side_choice].name
    @order_price << @side_dish[side_choice].price
    main_menu
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
    puts "$#{@result}"
    puts
  end

  def remove_item
    while @order_item.empty?
      puts "You have no items to remove"
      puts
      ordering_main
    end
    puts "Pick an item to remove"
    @order_item.each_with_index do |f, i|
      puts "#{i + 1}) #{f}"
    end
    puts
    choice = gets.strip.to_i
    puts
    if choice > 0 && choice <= @order_item.length
      puts "You removed #{@order_item[choice - 1]}"
      puts
      @order_item.delete_at(choice - 1)
      @order_price.delete_at(choice - 1)
      @result = @order_price.inject(0){|sum,x| sum + x}
      main_menu
    else
      puts "Invalid Choice"
      puts
      remove_item
    end
  end
  
  def remove_order
    if @order_item.empty?
      puts
      puts "You haven't ordered anything!"
      puts
      main_menu
    else
      @order_price.clear
      @order_item.clear
      puts
      puts "Your order has be removed"
      puts
      main_menu
    end
  end

  def purchase
    while @order_item.empty?
      puts
      puts "You have no items"
      puts
      main_menu
    end
    if @result <= @user_wallet
      puts
      puts "Your total change is $#{@user_wallet - @result}"
      puts "Enjoy your meal #{@user_name}!!!"
      exit
    else
      puts
      puts "Insufficient funds"
      puts "Please remove items or cancle order"
      puts
      main_menu
    end
  end
end

LunchLady.new

