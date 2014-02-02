FactoryGirl.define do
  factory :location do
    destination_for_puzzles { [ FactoryGirl.create(:puzzle) ] }

    factory :location_A do
      name 'Location A'
      token 'a1b2c3d4'
      latitude -34.001
      longitude -87.501
      address 'Springfield, IL'
    end

    factory :location_B do
      name 'Location B'
      token '13112ld4'
      latitude 43.001
      longitude -57.501
      address 'New York, NY'
    end

    factory :location_C do
      name 'Location C'
      token 'pi3llz1h'
      latitude 13.001
      longitude -17.501
      address 'Chicago, IL'
    end

    factory :location_D do
      name 'Location D'
      token '1298uo12'
      latitude 0.0
      longitude 0.0
      address 'Knoxville, TN'
    end
  end
end
