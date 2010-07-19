require 'redmine'

Redmine::Plugin.register :redmine_remove_membership do
  name 'Remove Membership'
  author 'Eric Davis'
  description 'Adds a Rake task to remove all memberships for a specific user'
  url 'https://projects.littlestreamsoftware.com/projects/redmine-misc'
  author_url 'http://www.littlestreamsoftware.com'
  version '0.1.0'

  requires_redmine :version_or_higher => '0.9.0'
end
