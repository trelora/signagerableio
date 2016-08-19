class Role < ActiveRecord::Base
  def self.update_roles
    roles = fetch_roles
    delete_roles
    insert_roles(roles)
  end

  def self.all_roles
    Role.all.pluck(:role)
  end

  private
    def self.delete_roles
      Role.delete_all
    end

    def self.fetch_roles
      TreloraServices.new.get_roles
    end

    def self.insert_roles(roles)
      roles.each do |role|
        Role.create(role: role)
      end
    end
end
