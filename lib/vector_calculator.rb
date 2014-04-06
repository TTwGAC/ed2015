# encoding: utf-8

class VectorCalculator
  # Distance of 1 degree calculated for 33.7 degrees latitude
  # http://msi.nga.mil/MSISiteContent/StaticFiles/Calculators/degree.html
  # Magnetic variation calculated for Atlanta
  # http://magnetic-declination.com/
  LENGTH_OF_1DEG_LAT = 363901
  LENGTH_OF_1DEG_LON = 304161
  MAGNETIC_VARIATION = -4.88

  def self.calc_distance(lat1, lon1, lat2, lon2)
    dlat = lat2 - lat1
    dlon = lon2 - lon1

    a = dlat * LENGTH_OF_1DEG_LAT
    b = dlon * LENGTH_OF_1DEG_LON

    distance = Math.sqrt(a**2 + b**2)

    heading = ((Math.atan2(a,b) * 360 / (Math::PI * 2)) * -1) + 90
    heading += MAGNETIC_VARIATION

    heading += 360 if heading < 0

    [heading, distance]
  end

  # Colbeh
  #lat1 = 33.774249
  #lon1 = -84.2950631

  # Paper Plane
  #lat2 = 33.774908
  #lon2 = -84.2960323
end
