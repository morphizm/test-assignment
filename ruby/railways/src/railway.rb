require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'car'
require_relative 'cargo_car'
require_relative 'passenger_car'

class Railway
  def initialize
    @trains = []
    @stations = []
    @routes = []
    @cars = []
    @cur_train = nil
    @cur_station = nil
    @cur_route = nil
    @cur_car = nil
  end

  def run
    main_menu
  end

  private

  def show_main_menu
    text_menu = 'Введите 1, чтобы создать станцию, поезд, вагон или маршрут' \
    "\nВведите 2, чтобы произвести действие с раннее созданным объектом" \
    "\nВведите 3, чтобы посмотреть список станций или поездов" \
    "\nВведите 0, чтобы выйти"
    puts text_menu
  end

  def main_menu
    show_main_menu
    input = gets.chomp.to_i
    if input == 1
      create
      main_menu
    elsif input == 2
      act
      main_menu
    elsif input == 3
      print_list
      main_menu
    else
      return
    end
  end

  def show_creater_menu
    text = 'Введите 1, чтобы создать станцию' \
    "\nВведите 2, чтобы создать поезд" \
    "\nВведите 3, чтобы создать вагон, cargo или passenger" \
    "\nВведите 4, чтобы создать маршрут"
    puts text
  end

  def create
    show_creater_menu
    input = gets.chomp.to_i
    if input == 1
      create_station
    elsif input == 2
      create_train
    elsif input == 3
      create_car
    elsif input == 4
      create_route
    else
      return
    end
  end

  def create_station
    begin
      puts 'Введите название станции'
      st_name = gets.chomp
      station = Station.new(st_name)
      @stations << station
    rescue RuntimeError => e
      puts e.message
      retry
    end
    puts "Успешно, станция '#{station.name}' создана"
  end

  def create_train
    begin
      puts 'Введите название поезда'
      tr_name = gets.chomp
      puts 'Введите тип поезда, 1 - грузовой, 2 - пассажирский'
      tr_type = gets.chomp.to_i
      if tr_type == 1
        train = CargoTrain.new(tr_name)
        @trains << train
      elsif tr_type == 2
        train = PassengerTrain.new(tr_name)
        @trains << train
      else
        puts 'Некоректный тип поезда'
        create_train
        return
      end
    rescue RuntimeError => e
      puts e.message
      retry
    end
    puts "Успешно, поезд '#{tr_name}' создан"
  end

  def create_car
    puts 'Введите тип вагона, 1 - грузовой, 2 - пассажирский'
    car_type = gets.chomp.to_i
    if car_type == 1
      puts 'Введите объем вагона'
      size = gets.chomp.to_i
      car = CargoCar.new(size)
      puts "Успешно, вагон '#{car}' создан"
      @cars << car
      return
    elsif car_type == 2
      puts 'Введите количество мест'
      size = gets.chomp.to_i
      car = PassengerCar.new(size)
      puts "Успешно, вагон '#{car}' создан"
      @cars << car
      return
    else
      puts 'Неверный тип вагона'
      puts 'Вагон не создан'
    end
  end

  def create_route
    begin
      puts 'Введите 0 для выхода'
      puts 'Начальный пункт'
      input = pick_station
      return if input == '0'
      r_from = @cur_station
      puts 'Конечный пункт'
      pick_station
      r_to = @cur_station
      route = Route.new(r_from, r_to)
      @routes << route
    rescue RuntimeError => e
      puts e.message
      retry
    end
    puts "Успешно, маршрут '#{route}' создан"
  end

  def show_picks_menu
    text = 'Введите 1, чтобы выбрать станцию' \
    "\nВведите 2, чтобы выбрать поезд" \
    "\nВведите 3, чтобы выбрать вагон" \
    "\nВведите 4, чтобы выбрать маршрут"
    puts text
  end

  def pick
    show_picks_menu
    input = gets.chomp.to_i
    if input == 1
      pick_station
    elsif input == 2
      pick_train
    elsif input == 3
      pick_car
    elsif input == 4
      pick_route
    end
  end

  def pick_station
    puts 'Введите название станции'
    st_name = gets.chomp
    station = @stations.find { |el| el.name == st_name }
    if station.nil?
      puts 'Станция не найдена'
      @cur_station = station
      return st_name
    end
    @cur_station = station
  end

  def pick_train
    puts 'Введите название поезда'
    tr_name = gets.chomp.to_s
    train = @trains.find { |el| el.number == tr_name }
    if train.nil?
      puts 'Поезд не найден'
    end
    @cur_train = train
  end

  def pick_car
    puts 'Введите номер, чтобы выбрать вагон'
    i = 0
    @cars.each do |el|
      puts "Вагон #{i}, #{el}"
      i += 1
    end
    car_index = gets.chomp.to_i
    @cur_car = @cars[car_index]
    if @cur_car.nil?
      puts 'Вагон не найден'
    end
  end

  def pick_route
    puts 'Введите номер, чтобы выбрать маршрут'
    i = 0
    @routes.each { |el|
      puts "Маршрут #{i}, #{el}"
      i += 1
    }
    r_index = gets.chomp.to_i
    @cur_route = @routes[r_index]
    if @cur_route.nil?
      puts 'Маршрут не найден'
    end
  end

  def show_actions_menu
    text = 'Введите 1, чтобы произвести действия со станцией' \
    "\nВведите 2, чтобы произвести действия с поездом" \
    "\nВведите 3, чтобы произвести действия c маршрутом" \
    "\nВведите 4, чтобы произвести действия с вагоном" \
    "\nВведите 5, чтобы выбрать объект"
    puts text
  end

  def act
    show_actions_menu
    input = gets.chomp.to_i
    if input == 1
      act_station
    elsif input == 2
      act_train
    elsif input == 3
      act_route
    elsif input == 4
      act_car
    elsif input == 5
      pick
      act
    end
  end

  def show_act_station_menu
    text = 'Введите 1, чтобы добавить станцию в маршрут' \
    "\nВведите 2, чтобы удалить станцию из маршрута"
    puts text
  end

  def act_station
    show_act_station_menu
    act_num = gets.chomp.to_i
    pick_route
    pick_station
    if @cur_route && @cur_station
      if act_num == 1
        @cur_route.add_station(@cur_station)
        return
      elsif act_num == 2
        @cur_route.remove_station(@cur_station)
        return
      end
    end
  end

  def show_act_train_menu
    text = 'Введите 1, чтобы добавить вагон поезду' \
    "\nВведите 2, чтобы отцепить вагон от поезда"
    puts text
  end

  def act_train
    show_act_train_menu
    act_num = gets.chomp.to_i
    pick_train
    pick_car
    if @cur_train && @cur_car
      if act_num == 1
        @cur_train.add_car(@cur_car)
        return
      elsif act_num == 2
        @cur_train.add_car(@cur_car)
        return
      end
    end
  end

  def show_act_route_menu
    text = 'Введите 1, чтобы назначить маршрут поезду' \
    "\nВведите 2, чтобы переместить поезд по маршруту вперёд" \
    "\nВведите 3, чтобы переместить поезд по маршруту назад"
    puts text
  end

  def act_route
    show_act_route_menu
    act_num = gets.chomp.to_i
    pick_route
    pick_train
    if @cur_train && @cur_route
      if act_num == 1
        @cur_train.route(@cur_route)
      elsif act_num == 2
        @cur_train.to_next_station
      elsif act_num == 3
        @cur_train.to_prev_station
      end
    end
  end

  def act_car
    # puts "Введите 1, чтобы занять место или объём в вагоне"
    # act_num = gets.chomp.to_i
    pick_car
    return unless @cur_car
    if @cur_car.instance_of?(CargoCar)
      puts 'Введите объём, который хотите занять'
      size = gets.chomp.to_i
      @cur_car.take_size(size)
      puts 'Успешно!'
      return
    end
    @cur_car.take_size(size)
    puts 'Успешно'
  end

  def show_lists_menu
    text = 'Введите 1, чтобы Посмотреть список станций' \
    "\nВведите 2, чтобы Посмотреть список поездов на станции" \
    "\nВведите 3, чтобы Посмотреть список вагонов у поезда"
    puts text
  end

  def print_list
    show_lists_menu
    pr_num = gets.chomp.to_i
    if pr_num == 1
      @stations.each { |el| puts el }
      return
    elsif pr_num == 2
      pick_station
      return unless @cur_train
      train_block = proc do |train|
        number = train.number
        type = train.instance_of?(CargoTrain) ? 'Грузовой' : 'Пассажирский'
        cars = train.cars.length
        puts 'Номер поезда, Тип, Количество вагонов'
        print number, ', ', type, ', ', cars, "\n"
      end
      @cur_station.go_by_trains(&train_block)
    elsif pr_num == 3
      pick_train
      return unless @cur_train
      show_for_cargo = 'Количество свободного объёма, Количество занятого объёма'
      show_for_pas = 'Количество свободных мест, Количество занятых мест'
      car_block = proc do |car|
        number = car.object_id
        type = car.instance_of?(CargoCar) ? 'Грузовой' : 'Пассажирский'
        puts "Номер вагон, Тип, #{@cur_train.instance_of?(CargoTrain) ? show_for_cargo : show_for_pas}"
        print number, ', ', type, ', ', car.free_size, ', ', car.busy_size, "\n"
      end
      @cur_train.go_by_cars(&car_block)
    else
      return
    end
  end
end
