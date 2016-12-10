class Ability
  include CanCan::Ability

  def initialize(user, access)
    @user = user
    @access = access
    set_admin_permissions
  end
    def set_admin_permissions
      return unless access.admin?
      can :manage, :all if access.admin?
    end
end
