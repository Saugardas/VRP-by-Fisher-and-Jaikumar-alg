require 'kmeans-clusterer'
require_relative 'tsp'

class FisherJaikumar
  def initialize(points:, courier_num:)
    @points = points
    @courier_num = courier_num
  end

  def solve
    clusters.each do |cluster|
      tsp = TSP.new(points: cluster)
      tsp.calculate_route
      tsp.pretty_print
    end
  end

  private

  def clusters
    KMeansClusterer.run(@courier_num, @points).clusters.map { |cl| cl.points.map(&:data) }
  end
end

if __FILE__ == $0
  data = [
      [3,6], [2,3], [5,4], [1,1], [5,2], [4,0], [6,1],
      [0,-2], [2,-2], [1, -3], [6, -3], [4, -6], [-3,4],
      [-4,2], [-2,2], [0,3], [-6,0], [-4,0], [-5,-1],
      [-3,-1], [-5,-3], [-2,-3], [-4,-4], [-1,-4],
      [-5,-6], [-3,-6], [-2,-9]
  ]
  fj = FisherJaikumar.new(points: data, courier_num: 2)
  fj.solve
end
