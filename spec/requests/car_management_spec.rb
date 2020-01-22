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

    xit 'model not found' do
      get api_v1_car_path(id: 999)
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'index' do
    it 'render correctly' do
       car = create_list(:car, 5)

       get api_v1_car_path
       json = JSON.parse(response.body, symbolize_names: true)

       expect(json.first[:car_model_id])
    end
  end
end
