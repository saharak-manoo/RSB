# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # can :read, :all

    if user.present?
      can :manage, :all
    end
  end
end
