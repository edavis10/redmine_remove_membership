namespace :redmine_remove_membership do

  desc <<END_DESC
Remove all memberships for a specific user.

General options:
  user=user login    Login or id of the user who should have memberships removed
  except=projects    Identifiers or ids of projects to not remove, comma separated

Examples:
  rake redmine_remove_membership:remove user=admin except="1,23"
  rake redmine_remove_membership:remove user=1 except="a-project, another"
END_DESC

  task :remove => :environment do
    user_param = (ENV['user'] || '').strip
    user = User.find_by_id(user_param)
    user ||= User.find_by_login(user_param)
    raise "Cannot find user" unless user.present?
    
    except = (ENV['except'] || '').split(',').inject([]) {|projects, exception|
      exception.strip!
      project = Project.find_by_id(exception)
      project ||= Project.find_by_identifier(exception)
      projects << project if project
      projects
    }

    user.memberships(:include => :project).each {|membership|
      membership.destroy unless except.include?(membership.project)
    }
  end
end
