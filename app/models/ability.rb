class Ability
  include CanCan::Ability

  def initialize(user)
    if user.master?
        agent_master(user)
    else
        agent_user(user)
    end
  end

  protected

  def agent_master(user)
      can [:index,:show,:archived,:archive,:archive_multiple], Message
      can [:edit,:update,:index,:messages], User
  end

  def agent_user(user)
     can [:index,:show,:create,:new,:sent,:archive,:archive_multiple], Message
     can [:edit,:update], User
  end
end
