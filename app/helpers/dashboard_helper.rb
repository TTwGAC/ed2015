# encoding: utf-8

module DashboardHelper
  def teams_sorted_by_score
    Team.playing.sort_by do |team|
      if team.score <= 0
        99999999999
      else
        team.score
      end
    end
  end
end
