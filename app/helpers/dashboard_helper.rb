# encoding: utf-8

module DashboardHelper
  def teams_sorted_by_score
    Team.player.sort_by {|team| team.score}
  end
end
