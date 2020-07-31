class WebApp < Sinatra::Base

  helpers do
    def create_station(info)
      Station.new(info['name'])
    end

    def create_route(info)
      first = info['station1']
      last = info['station2']
      Route.new(first, last)
    end

    def create_train(info)
      if info['type'] == 'Passenger'
        PassengerTrain.new(info['number'])
      else
        CargoTrain.new(info['number'])
      end
    end

    def store_station(info)
      station_info = {id: "#{rand(36**8).to_s(36)}", name: "#{info['name']}", created_at: "#{Time.now}"}
      write_file(station_info.to_json, 'data/stations.txt') 
    end

    def store_route(info)
      route_info = {id: "#{rand(36**8).to_s(36)}", name: "#{info['station1']}-#{info['station2']}", created_at: "#{Time.now}"}
      write_file(route_info.to_json, 'data/routes.txt') 
    end

    def store_train(info)
      train_info = {id: "#{rand(36**8).to_s(36)}", number: "#{info['number']}", type: "#{info['type']}", created_at: "#{Time.now}"}
      write_file(train_info.to_json, 'data/trains.txt') 
    end

    def read_info(file_path)
      return [] unless File.exist?(file_path)
      
      File.read(file_path).split("\n")
    end

    def write_file(data, file_path)
      File.open(file_path, 'a+') { |file| file.puts(data) }
    end
  end

  get '/' do
    erb :index
  end

  get '/stations' do
    @stations_info = read_info('data/stations.txt')
    erb :stations
  end

  post '/stations' do
    station = create_station(params)
    halt(400, "Error occured") unless station.valid?

    store_station(params)
    redirect '/stations'
  end

  get '/routes' do
    @stations_info = read_info('data/stations.txt')
    @routes_info = read_info('data/routes.txt')
    erb :routes
  end

  post '/routes' do
    route = create_route(params)
    halt(400, "Error occured") unless route.valid?

    store_route(params)
    redirect '/routes'
  end

  get '/trains' do
    @trains_info = read_info('data/trains.txt')
    erb :trains
  end

  post '/trains' do
    train = create_train(params)
    halt(400, "Error occured") unless train.valid?

    store_train(params)
    redirect '/trains'
  end
end
