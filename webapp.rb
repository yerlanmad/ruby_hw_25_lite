class WebApp < Sinatra::Base

  helpers do
    def create_train(params)
      if params['type'] == 'Passenger'
        PassengerTrain.new(params)
      else
        CargoTrain.new(params)
      end
    end

    def read_info(file_path)
      return [] unless File.exist?(file_path)
      
      File.read(file_path).split("\n")
    end

    def stations_name
      read_info('data/stations.txt').map { |station| JSON.parse(station)['name'] }
    end

    def serialize(file_path)
      read_info(file_path).map { |route| JSON.parse(route) }
    end
  end

  get '/' do
    erb :index
  end

  get '/stations' do
    @stations_info = serialize('data/stations.txt')
    erb :stations
  end

  post '/stations' do
    station = Station.new(params)
    halt(400, "Error occured") unless station.valid?

    redirect '/stations'
  end

  get '/routes' do
    @stations = stations_name
    @routes_info = serialize('data/routes.txt')
    erb :routes
  end

  post '/routes' do
    route = Route.new(params)
    halt(400, "Error occured") unless route.valid?

    redirect '/routes'
  end

  get '/trains' do
    @trains_info = serialize('data/trains.txt')
    erb :trains
  end

  post '/trains' do
    train = create_train(params)
    halt(400, "Error occured") unless train.valid?

    redirect '/trains'
  end
end
