require 'rails_helper'

describe 'Cars Management' do
  context 'show' do
    it 'render car correctly' do
      car = create(:car)

      get api_v1_car_path(car)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[:car_model_id]).to eq(car.car_model_id)
      expect(json[:car_km]).to eq(car.car_km)
      expect(json[:license_plate]).to eq(car.license_plate)
      expect(json[:color]).to eq(car.color)
      expect(json[:status]).to eq(car.status)
      expect(json[:subsidiary_id]).to eq(car.subsidiary_id)
    end

    it 'model not found' do
      get api_v1_car_path(id: 999)
      expect(response).to have_http_status(:not_found)
    end
  end

  xcontext 'index' do
    it 'render correctly' do
       car = create_list(:car, 5)

       get api_v1_car_path
       json = JSON.parse(response.body, symbolize_names: true)

       expect(json.first[:car_model_id])
    end
  end

  context 'post' do
    it 'created correctly' do
      car_model = create(:car_model)
      subsidiary = create(:subsidiary)
   
      post api_v1_cars_path, params: {
                                      car: {car_km: 1, license_plate: "QWE", color: "black", 
                                            car_model_id: car_model.id,
                                            subsidiary_id: subsidiary.id
                                            }
                                      }
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[:car_km]).to eq(1)
      expect(json[:license_plate]).to eq("QWE")
      expect(json[:car_model_id]).to eq(car_model.id)
      expect(json[:subsidiary_id]).to eq(subsidiary.id)
      expect(json[:color]).to eq("black")
    end

    it 'upload car image' do
      car_model = create(:car_model)
      subsidiary = create(:subsidiary)
   
      post api_v1_cars_path, params: {
                                      car: {car_km: 1, license_plate: "QWE", color: "black", 
                                            car_model_id: car_model.id,
                                            subsidiary_id: subsidiary.id
                                            }
                                      }
    end

    it 'not created successfully' do
      post api_v1_cars_path, params: { car: {}}

      expect(response).to have_http_status(412)
    end

    it 'not send mandatory fields' do
      car_model = create(:car_model)
      subsidiary = create(:subsidiary)

      post api_v1_cars_path, params: {
                                      car: {car_km: 1, license_plate: "QWE", color: "black", 
                                            car_model_id: car_model.id, subsidiary_id: nil
                                            }
                                      }
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(412)
      expect(json[:message]).to include('Filial é obrigatório(a)')
    end
  end

  context 'delete' do
    it 'delete correctly' do
      car = create(:car)
      
      delete api_v1_car_path(car)
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to have_http_status(200)
      expect(json[:message]).to include('Carro excluido com sucesso')
    end
  end
end
