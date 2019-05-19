# Класс для решения задачи коммивояжёра методом ближайшего соседа (O(n^2))
class TSP
  TIME_COST = 10 # минут на 1 единицу пути
  attr_reader :travel_time, :route

  def initialize(points:)
    @points = points.map(&:to_a)
    @travel_time = 0
    @route = [[0, 0]]
  end

  def calculate_route
    points = @points.map { |point| [point, distance(point, @route.last)] }
    while points.size.positive?
      next_point, time = points.sort_by!(&:last).shift
      add_to_route(point: next_point, time: time)
      points = points.map! { |point, _| [point, distance(point, next_point)] }
    end
    add_to_route(point: [0, 0], time: distance(@route.last, [0, 0]))
  end

  def pretty_print
    p '#'*15
    p "Маршрут со временем #{@travel_time}"
    p @route.map(&:to_s).join('->')
  end

  private

  def add_to_route(point:, time:)
    @route << point
    @travel_time += time * TIME_COST
  end

  def distance(p1, p2)
    Math.sqrt((p1[0] - p2[0])**2 + (p1[1] - p2[1])**2)
  end
end
