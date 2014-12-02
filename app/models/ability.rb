# A CanCan configuration file that determines privileges based upon user role.
# @author Eric Schlange <eric.schlange@northwestern.edu>
class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)

    if user.at_least_a_super_user?
      can :manage, :all
      can :access, :rails_admin   # grant access to rails_admin
      can :dashboard              # grant access to the dashboard
    elsif user.at_least_a_admin?
      can :manage, :all
    end
  end
end
