class Ability
  include CanCan::Ability

  def initialize(player)
    player ||= Player.new

    case player.role
    when "admin"
      can :manage, :all
    when "player"
      can [:edit, :update], Team, id: player.team_id
      can [:create, :destroy], TeamInvitation, team_id: player.team_id
      can [:create, :destroy], JoinAttempt
      can :create, Checkin
      can :read, Checkin, team_id: player.team_id
      can :read, Document, private: false
    when "observer"
      can :create, Team
      can :create, JoinAttempt
    end

    can :manage, Player, id: player.id

    can :read, Team
    can :read, Player

    # Define abilities for the passed in player here. For example:
    #
    #   player ||= Player.new # guest player (not logged in)
    #   if player.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the player 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the player can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the player can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
